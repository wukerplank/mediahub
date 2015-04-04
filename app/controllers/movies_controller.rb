class MoviesController < ApplicationController

  def index
    @movies = MediaFile.where(media_type: MediaType.new('movie')).paginate(page: params[:page])
  end

end
