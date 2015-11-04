class MoviesController < ApplicationController

  def index
    @movies = MediaFile.order('filename').where(media_type: MediaType.new('movie'))

    if params[:filter].present?
      case params[:filter]
      when 'withoutid'
        @movies = @movies.where(imdb_id: nil)
      when 'duplicates'
        @duplicates = MediaFile.connection.select_all("SELECT imdb_id, COUNT(*) AS duplicates FROM media_files
        WHERE imdb_id IS NOT NULL AND imdb_id != \"\"
        GROUP BY imdb_id
        HAVING duplicates > 1")

        @movies = @movies.where(imdb_id: @duplicates.map{ |d| d['imdb_id'] } )
      end
    end

    @movie_count = @movies.count
    @movies = @movies.paginate(page: params[:page])
  end

end
