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

ActiveRecord::Schema.define(version: 2022_03_18_104539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choices", force: :cascade do |t|
    t.integer "area"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comment_meetings", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "user_id"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "follow_regularmeetings", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "user_id"
    t.integer "meeting_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "follow_status"
  end

  create_table "regularmeetings", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.date "participation_day"
    t.string "transportation"
    t.string "playstyle"
    t.string "appeal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "place_id"
  end

  create_table "survfields", force: :cascade do |t|
    t.string "field_name"
    t.float "lat"
    t.float "lng"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "place_id"
    t.string "viewport"
    t.string "formatted_address"
    t.string "rating"
    t.string "formatted_phone_number"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "account_name"
    t.string "account_id"
    t.text "image"
    t.string "memo"
    t.integer "age"
    t.integer "sex"
    t.integer "experience"
    t.integer "playstyle"
    t.integer "holiday"
    t.integer "participation"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "went_survfields", force: :cascade do |t|
    t.integer "user_id"
    t.string "place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
