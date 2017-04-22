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

ActiveRecord::Schema.define(version: 20170422203434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_categories_products_on_category_id", using: :btree
    t.index ["product_id"], name: "index_categories_products_on_product_id", using: :btree
  end

  create_table "orderitems", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "product_id"
    t.index ["order_id"], name: "index_orderitems_on_order_id", using: :btree
    t.index ["product_id"], name: "index_orderitems_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "name_on_card"
    t.string   "card_number"
    t.string   "exp_month"
    t.string   "exp_year"
    t.string   "cvv"
    t.string   "billing_zip_code"
    t.string   "order_state"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
    t.string   "photo_url"
    t.float    "price"
    t.integer  "quantity"
    t.integer  "vendor_id"
    t.index ["vendor_id"], name: "index_products_on_vendor_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating"
    t.text     "comment"
    t.integer  "product_id"
    t.index ["product_id"], name: "index_reviews_on_product_id", using: :btree
  end

  create_table "vendors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "uid"
    t.string   "provider"
    t.string   "email"
    t.string   "username"
  end

  add_foreign_key "orderitems", "orders"
  add_foreign_key "orderitems", "products"
  add_foreign_key "products", "vendors"
end
