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

ActiveRecord::Schema.define(version: 2020_01_21_092313) do

  create_table "hotels", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.integer "destination_id", null: false
    t.string "name"
    t.json "location"
    t.string "description"
    t.json "amenities"
    t.json "images"
    t.text "booking_conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_hotels_on_hotel_id", unique: true
  end

end
