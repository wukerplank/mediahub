json.movies @movies do |movie|
  json.id movie.id
  json.title movie.filename
  json.posterURL 'http://mediamaster.edthofer.at/assets/movie_150x225-6a0606a99f17f57ae917e906eb86365d.png'
  json.videoURL File.join(root_url, movie.public_path)
end
