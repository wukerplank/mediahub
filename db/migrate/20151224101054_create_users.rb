class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :mediamaster_nickname
      t.string :mediamaster_secret

      t.timestamps null: false
    end
  end
end
