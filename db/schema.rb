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

ActiveRecord::Schema.define(version: 20160807084528) do

  create_table "short_urls", force: :cascade do |t|
    t.string   "original_url"
    t.string   "short_url"
    t.integer  "user_id"
    t.integer  "visits_count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "short_visits", force: :cascade do |t|
    t.integer  "short_url_id"
    t.string   "visitor_ip"
    t.string   "visitor_city"
    t.string   "visitior_state"
    t.string   "visitor_country_iso"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "api_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
