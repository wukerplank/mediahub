# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150404161842) do

  create_table "media_files", force: :cascade do |t|
    t.string   "filename"
    t.string   "path"
    t.string   "media_type"
    t.string   "md5"
    t.datetime "ctime"
    t.datetime "mtime"
    t.datetime "atime"
    t.integer  "width"
    t.integer  "height"
    t.integer  "filesize",    limit: 8
    t.integer  "duration"
    t.string   "video_codec"
    t.string   "audio_codec"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "media_files", ["filename"], name: "index_media_files_on_filename"
  add_index "media_files", ["path"], name: "index_media_files_on_path"

  create_table "watch_folders", force: :cascade do |t|
    t.string   "folder"
    t.string   "media_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "watch_folders", ["media_type"], name: "index_watch_folders_on_media_type"

end
