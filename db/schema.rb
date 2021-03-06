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

ActiveRecord::Schema.define(version: 2019_05_15_124920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data", force: :cascade do |t|
    t.string "skin_type"
    t.string "prefered_color"
    t.string "prefered_scent"
    t.string "age_group"
    t.string "prefered_brand"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "zipcode"
    t.string "gender"
    t.string "department"
    t.index ["age_group"], name: "index_data_on_age_group"
    t.index ["department"], name: "index_data_on_department"
    t.index ["prefered_brand"], name: "index_data_on_prefered_brand"
    t.index ["prefered_color"], name: "index_data_on_prefered_color"
    t.index ["skin_type"], name: "index_data_on_skin_type"
    t.index ["zipcode"], name: "index_data_on_zipcode"
  end

end
