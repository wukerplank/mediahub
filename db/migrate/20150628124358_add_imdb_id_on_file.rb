class AddImdbIdOnFile < ActiveRecord::Migration
  def change
    add_column :media_files, :imdb_id, :string, index: true, after: :md5

    MediaFile.movie_type.find_each do |file|
      next unless file.filename.match(/.*\[(tt\d+)\].*/i)
      imdb_id = file.filename.gsub(/.*\[(tt\d+)\].*/i, "\\1")
      file.update_attributes(imdb_id: imdb_id)
    end
  end
end
