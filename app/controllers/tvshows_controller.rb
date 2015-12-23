class TvshowsController < ApplicationController

  def index
    title.push 'TV Shows'

    @tvshows = MediaFile.tvshow_type.order('filename').paginate(page: params[:page])
  end

end
