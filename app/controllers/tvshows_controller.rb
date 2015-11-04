class TvshowsController < ApplicationController

  def index
    @tvshows = MediaFile.tvshow_type.order('filename').paginate(page: params[:page])
  end

end
