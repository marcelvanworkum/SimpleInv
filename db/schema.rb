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

ActiveRecord::Schema.define(version: 2020_04_06_210907) do

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "quality"
    t.decimal "purchase_price", precision: 8, scale: 2
    t.decimal "purchase_postage_cost", precision: 8, scale: 2
    t.date "date_purchased"
    t.decimal "listing_price", precision: 8, scale: 2, null: false
    t.decimal "sale_price", precision: 8, scale: 2
    t.decimal "postage_cost", precision: 8, scale: 2, default: "0.0"
    t.date "date_sold"
    t.string "method_of_payment", default: "Eftpos", null: false
    t.string "location_of_sale", default: "Other", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "removal_date"
    t.string "removal_reason"
    t.boolean "barcoded", default: false, null: false
  end

end
