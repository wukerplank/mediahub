class MoviesController < ApplicationController

  def index
    @movies = MediaFile.order('filename').where(media_type: MediaType.new('movie')).paginate(page: params[:page])
  end

end
