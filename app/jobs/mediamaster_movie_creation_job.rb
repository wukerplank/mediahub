class MediamasterMovieCreationJob < ActiveJob::Base

  queue_as :mediamaster_movie_creation_job

  def perform(imdb_id, user_id)

    current_user = User.find(user_id)

    MediaMasterClient::Base.configure do |c|
      c.app_uid    = ENV['MEDIA_MASTER_CLIENT_APP_UID']
      c.app_secret = ENV['MEDIA_MASTER_CLIENT_APP_SECRET']
      c.host       = ENV['MEDIA_MASTER_CLIENT_HOST']
      c.username   = current_user.mediamaster_nickname
      c.password   = current_user.mediamaster_secret
    end

    logger.info "Client:"
    logger.info "    app_uuid: #{MediaMasterClient::Base.app_uid}"
    logger.info "  app_secret: #{MediaMasterClient::Base.app_secret}"
    logger.info "        host: #{MediaMasterClient::Base.host}"
    logger.info "    username: #{MediaMasterClient::Base.username}"
    logger.info "    password: #{MediaMasterClient::Base.password}"

    if MediaMasterClient::Movie.find_by_imdb_id(imdb_id)
      return
    end

    movie_data = ImdbApi::Movie.find(imdb_id)

    movie = MediaMasterClient::Movie.create(movie_data)

    movie_data[:cast].each do |acting_data|

      acting_data[:actable_type] = 'Movie'
      acting_data[:actable_id]   = movie.id

      unless person = MediaMasterClient::Person.find_by_imdb_id(acting_data[:imdb_id])
        person_data = ImdbApi::Person.find(acting_data[:imdb_id])
        person = MediaMasterClient::Person.create(person_data)
      end

      acting_data[:person_id] = person.id

      puts acting_data.inspect

      begin
        acting = MediaMasterClient::Acting.create(acting_data)
      rescue OAuth2::Error
        # ...
      rescue => e
        puts e.inspect
      end

    end

    movie_data[:directors].each do |directing_data|
      directing_data[:directable_type] = 'Movie'
      directing_data[:directable_id]   = movie.id

      unless person = MediaMasterClient::Person.find_by_imdb_id(directing_data[:imdb_id])
        person_data = ImdbApi::Person.find(directing_data[:imdb_id])
        person = MediaMasterClient::Person.create(person_data)
      end

      directing_data[:person_id] = person.id

      puts directing_data.inspect

      begin
        directing = MediaMasterClient::Directing.create(directing_data)
      rescue OAuth2::Error
        # ...
      rescue => e
        puts e.inspect
      end

      puts directing.inspect
    end
  end

end
