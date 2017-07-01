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

ActiveRecord::Schema.define(version: 20170626054214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "urls", force: :cascade do |t|
    t.string "url", null: false
    t.index ["url"], name: "index_urls_on_url", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.string "HTTP_VERSION"
    t.string "HTTP_USER_AGENT"
    t.string "HTTP_ACCEPT_LANGUAGE"
    t.string "REMOTE_ADDR"
    t.string "SERVER_NAME"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "url_id"
    t.index ["url_id"], name: "index_visits_on_url_id"
  end

  add_foreign_key "visits", "urls"
end
