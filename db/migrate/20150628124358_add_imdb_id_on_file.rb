class AddImdbIdOnFile < ActiveRecord::Migration[5.2]
  def change
    add_column :media_files, :imdb_id, :string, index: true, after: :md5

    MediaFile.movie_type.find_each do |file|
      file.save
    end
  end
end
