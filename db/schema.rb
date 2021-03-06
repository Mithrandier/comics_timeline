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

ActiveRecord::Schema.define(version: 20170727075117) do

  create_table "issues", force: :cascade do |t|
    t.integer  "series_id"
    t.integer  "release_id"
    t.string   "title",        null: false
    t.float    "issue_number"
    t.string   "cover"
    t.string   "details_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["release_id"], name: "index_issues_on_release_id"
    t.index ["series_id", "issue_number"], name: "index_issues_on_series_id_and_issue_number", unique: true
    t.index ["series_id"], name: "index_issues_on_series_id"
  end

  create_table "releases", force: :cascade do |t|
    t.datetime "released_at", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["released_at"], name: "index_releases_on_released_at", unique: true
  end

  create_table "series", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
