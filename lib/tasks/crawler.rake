namespace :crawler do

  desc 'Crawls all watch folders for movies'
  task :movies => :environment do
    MediaFile.movie_type.find_each do |file|
      file.destroy unless file.exists?
    end

    movie_type = MediaType.new('movie')

    WatchFolder.where(media_type: movie_type).each do |folder|
      RecursiveCrawler.run(folder.folder, movie_type)
    end
  end

  desc 'Crawls all the watch folders for tv shows'
  task :tvshows => :environment do
    MediaFile.tvshow_type.find_each do |file|
      file.destroy unless file.exists?
    end
    
    tvshow_type = MediaType.new('tvshow')

    WatchFolder.where(media_type: tvshow_type).each do |folder|
      RecursiveCrawler.run(folder.folder, tvshow_type)
    end
  end

end
