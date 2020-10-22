class MoviesController < ApplicationController

  def index
    title.push 'Movies'

    @movies = MediaFile.movie_type.order('filename')

    if params[:filter].present?
      case params[:filter]
      when 'withoutid'
        @movies = @movies.where(imdb_id: nil)
      when 'duplicates'
        @duplicates = MediaFile.connection.select_all("
          SELECT imdb_id FROM (
            SELECT imdb_id, COUNT(*) AS duplicates FROM media_files
            WHERE imdb_id IS NOT NULL AND imdb_id <> ''
            GROUP BY imdb_id
          ) AS subquery
          WHERE duplicates > 1")

        @movies = @movies.where(imdb_id: @duplicates.map{ |d| d['imdb_id'] } )
      end
    end

    respond_to do |format|
      format.html do
        @movie_count = @movies.count
        @movies = @movies.paginate(page: params[:page])
      end
      format.json
    end

  end

end
