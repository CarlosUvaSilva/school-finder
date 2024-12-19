# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_19_104252) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "street_name", null: false
    t.integer "street_number", null: false
    t.string "apartment_number"
    t.string "zip_code", null: false
    t.string "parish", null: false
    t.string "city", null: false
    t.string "phone_number", null: false
    t.string "email"
    t.float "latitude"
    t.float "longitude"
    t.index ["latitude", "longitude"], name: "index_schools_on_latitude_and_longitude"
  end
end
