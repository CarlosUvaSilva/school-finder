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

ActiveRecord::Schema[8.0].define(version: 2025_01_23_135403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"
  enable_extension "unaccent"

  create_table "education_levels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
  end

  create_table "school_education_levels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.bigint "education_level_id", null: false
    t.index ["education_level_id"], name: "index_school_education_levels_on_education_level_id"
    t.index ["school_id", "education_level_id"], name: "idx_on_school_id_education_level_id_0d1d07b814", unique: true
    t.index ["school_id"], name: "index_school_education_levels_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "street_name", null: false
    t.string "street_number", null: false
    t.string "apartment_number"
    t.string "zip_code", null: false
    t.string "parish", null: false
    t.string "city", null: false
    t.string "phone_number", null: false
    t.string "email"
    t.float "latitude"
    t.float "longitude"
    t.tsvector "tsv_accented"
    t.geography "g_coords", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.index ["g_coords"], name: "index_schools_on_g_coords", using: :gist
    t.index ["latitude", "longitude"], name: "index_schools_on_latitude_and_longitude"
    t.index ["tsv_accented"], name: "index_schools_on_tsv_accented", using: :gin
  end

  add_foreign_key "school_education_levels", "education_levels"
  add_foreign_key "school_education_levels", "schools"
end
