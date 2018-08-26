class MediaFilesController < ApplicationController

  before_action :find_media_file, only: ['show', 'edit', 'update']

  def index
    if params[:q] && params[:q].length > 2
      title.push "Results for \"#{params[:q]}\""
      @media_files = MediaFile.where('path LIKE ?', "%#{params[:q]}%").paginate(page: params[:page])
    else
      title.push 'Media Files'
      @media_files = MediaFile.paginate(page: params[:page])
    end
  end

  def show
    title.push @media_file.filename
  end

  def edit
    title.push @media_file.filename
  end

  def update
    if @media_file.update_attributes(media_file_params)
      redirect_to @media_file
    else
      title.push @media_file.filename
      render action: 'edit'
    end
  end

  private

  def media_file_params
    params.require(:media_file).permit(:filename)
  end

  def find_media_file
    @media_file = MediaFile.find(params[:id])
  end

end
