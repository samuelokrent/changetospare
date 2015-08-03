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

ActiveRecord::Schema.define(version: 20150730151445) do

  create_table "cards", force: :cascade do |t|
    t.binary   "number",            limit: 65535
    t.string   "expiration_month",  limit: 255
    t.string   "expiration_year",   limit: 255
    t.binary   "verification_code", limit: 65535
    t.string   "name",              limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "charities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "about",      limit: 65535
    t.string   "website",    limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "donations", force: :cascade do |t|
    t.float    "amount",     limit: 24
    t.string   "status_cd",  limit: 255
    t.integer  "charity_id", limit: 4
    t.integer  "card_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "donations", ["card_id"], name: "index_donations_on_card_id", using: :btree
  add_index "donations", ["charity_id"], name: "index_donations_on_charity_id", using: :btree

end
