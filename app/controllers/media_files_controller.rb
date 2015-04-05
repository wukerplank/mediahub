class MediaFilesController < ApplicationController

  def index
    if params[:q] && params[:q].length > 2
      @media_files = MediaFile.where('path LIKE ?', "%#{params[:q]}%").paginate(page: params[:page])
    else
      @media_files = MediaFile.paginate(page: params[:page])
    end
  end

  def show
    @media_file = MediaFile.find(params[:id])
  end

end
