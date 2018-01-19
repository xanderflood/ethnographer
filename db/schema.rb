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

ActiveRecord::Schema.define(version: 20180119011030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cultures", force: :cascade do |t|
    t.string "name"
    t.date "collected"
    t.text "comments"
    t.string "species"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.text "recipe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "uuid"
    t.float "weight"
    t.date "innoculated", null: false
    t.date "disposed"
    t.bigint "culture_id"
    t.bigint "parent_id"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "medium_id"
    t.index ["culture_id"], name: "index_units_on_culture_id"
    t.index ["medium_id"], name: "index_units_on_medium_id"
    t.index ["parent_id"], name: "index_units_on_parent_id"
  end

  add_foreign_key "units", "cultures"
  add_foreign_key "units", "media"
  add_foreign_key "units", "units", column: "parent_id"
end
