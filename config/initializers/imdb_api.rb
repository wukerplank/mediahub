ImdbApi::Base.configure do |c|
  c.cache_directory = ENV['IMDB_API_CACHE_DIRECTORY']
end
