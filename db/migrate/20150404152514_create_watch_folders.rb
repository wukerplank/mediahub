class CreateWatchFolders < ActiveRecord::Migration
  def change
    create_table :watch_folders do |t|

      t.string :folder
      t.string :media_type, index: true

      t.timestamps null: false
    end
  end
end
