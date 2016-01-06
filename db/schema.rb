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

ActiveRecord::Schema.define(version: 20160106193708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.integer "property_id", null: false
    t.date    "date",        null: false
    t.integer "status",      null: false
    t.integer "price"
  end

  add_index "listings", ["price"], name: "index_listings_on_price", using: :btree
  add_index "listings", ["property_id", "date"], name: "index_listings_on_property_id_and_date", unique: true, using: :btree

  create_table "properties", force: :cascade do |t|
    t.integer "zipcode",     null: false
    t.integer "bedrooms"
    t.integer "accomodates", null: false
  end

  add_index "properties", ["bedrooms"], name: "index_properties_on_bedrooms", using: :btree
  add_index "properties", ["zipcode"], name: "index_properties_on_zipcode", using: :btree

  add_foreign_key "listings", "properties"
end
