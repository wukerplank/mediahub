class MoviesController < ApplicationController

  def index
    @movies = MediaFile.order('filename').where(media_type: MediaType.new('movie')).paginate(page: params[:page])
  end

  def duplicates
    @duplicates = MediaFile.connection.select_all("SELECT imdb_id, COUNT(*) AS duplicates FROM media_files
    WHERE imdb_id IS NOT NULL AND imdb_id != \"\"
    GROUP BY imdb_id
    HAVING duplicates > 1")

    @movies = MediaFile.where(imdb_id: @duplicates.map{ |d| d['imdb_id'] } )
  end

end
