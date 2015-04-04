class WatchFoldersController < ApplicationController

  def index
    @movie_watch_folders = WatchFolder.movie_type.order('folder').all
    @tvshow_watch_folders = WatchFolder.tvshow_type.order('folder').all
  end

  def new
    @watch_folder = WatchFolder.new
  end

  def create
    @watch_folder = WatchFolder.new(watch_folder_params)

    if @watch_folder.save
      redirect_to WatchFolder
    else
      render 'new'
    end
  end

  private

  def watch_folder_params
    params.require(:watch_folder).permit(:folder, :media_type)
  end

end
