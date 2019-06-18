# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_18_153933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "report_station_telemetries", force: :cascade do |t|
    t.bigint "station_id"
    t.integer "empty_slots"
    t.integer "free_bikes"
    t.json "by_hour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["station_id"], name: "index_report_station_telemetries_on_station_id"
  end

  create_table "stations", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name"
    t.string "external_id"
    t.string "raw_name"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_stations_on_company_id"
  end

  create_table "telemetries", force: :cascade do |t|
    t.bigint "station_id"
    t.datetime "captured_at"
    t.integer "empty_slots"
    t.integer "free_bikes"
    t.json "raw_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["station_id"], name: "index_telemetries_on_station_id"
  end

  add_foreign_key "report_station_telemetries", "stations"
  add_foreign_key "stations", "companies"
  add_foreign_key "telemetries", "stations"
end
