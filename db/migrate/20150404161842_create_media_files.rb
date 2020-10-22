class CreateMediaFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :media_files do |t|
      t.string :filename, index: true
      t.string :path, index: true
      t.string :media_type
      t.string :md5
      t.datetime :ctime
      t.datetime :mtime
      t.datetime :atime
      t.integer :width
      t.integer :height
      t.integer :filesize, limit: 8
      t.integer :duration
      t.string :video_codec
      t.string :audio_codec

      t.timestamps null: false
    end
  end
end
