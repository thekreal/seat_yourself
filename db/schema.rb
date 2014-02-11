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

ActiveRecord::Schema.define(version: 20140211204439) do

  create_table "locations", force: true do |t|
    t.string   "address"
    t.integer  "number_of_seats"
    t.time     "open_at"
    t.time     "close_at"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "locations", ["restaurant_id"], name: "index_locations_on_restaurant_id"

  create_table "reservations", force: true do |t|
    t.integer  "member_id"
    t.integer  "location_id"
    t.integer  "number_of_people"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "datetime"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_owner_id"
  end

  add_index "restaurants", ["restaurant_owner_id"], name: "index_restaurants_on_restaurant_owner_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

end
