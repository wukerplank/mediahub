namespace :crawler do

  desc 'Crawls all watch folders for movies'
  task :movies => :environment do
    MediaFile.find_each do |file|
      file.destroy unless file.exists?
    end

    movie_type = MediaType.new('movie')

    WatchFolder.where(media_type: movie_type).each do |folder|
      RecursiveCrawler.run(folder.folder, movie_type)
    end
  end

end
