class MediaFilesController < ApplicationController

  def index
    @media_files = MediaFile.paginate(page: params[:page])
  end

  def show
    @media_file = MediaFile.find(params[:id])
  end

end
