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

ActiveRecord::Schema.define(version: 20150705014730) do

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hating_ingredient"
    t.string   "loving_taste"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true

  create_table "events", force: :cascade do |t|
    t.text     "host_email"
    t.text     "name"
    t.text     "accept_email"
    t.text     "decline_email"
    t.text     "pending_email"
    t.text     "address"
    t.datetime "occur_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "category"
    t.string   "ingredient"
    t.string   "taste"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "image"
  end

end
