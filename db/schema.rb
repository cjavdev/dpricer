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

ActiveRecord::Schema.define(version: 20180625025115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listing_days", force: :cascade do |t|
    t.integer "listing_id", null: false
    t.integer "price", null: false
    t.date "price_on", null: false
    t.boolean "blocked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_listing_days_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "headline"
    t.string "description"
    t.string "photo_url"
    t.integer "channel_id"
    t.integer "external_id"
    t.integer "accommodates"
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.integer "beds"
    t.float "lat"
    t.float "lng"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accommodates"], name: "index_listings_on_accommodates"
    t.index ["bedrooms"], name: "index_listings_on_bedrooms"
    t.index ["channel_id"], name: "index_listings_on_channel_id"
    t.index ["external_id"], name: "index_listings_on_external_id"
  end

end
