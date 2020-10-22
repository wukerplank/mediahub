class CreateWatchFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :watch_folders do |t|

      t.string :folder
      t.string :media_type, index: true

      t.timestamps null: false
    end
  end
end
