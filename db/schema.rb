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

ActiveRecord::Schema.define(version: 2018_12_19_012731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deal_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.bigint "issuer_id"
    t.bigint "deal_category_id"
    t.date "pricing"
    t.date "settlement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_category_id"], name: "index_deals_on_deal_category_id"
    t.index ["issuer_id"], name: "index_deals_on_issuer_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "investor_id"
    t.bigint "marketing_id"
    t.string "comment"
    t.string "volume"
    t.integer "intent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investor_id"], name: "index_feedbacks_on_investor_id"
    t.index ["marketing_id"], name: "index_feedbacks_on_marketing_id"
  end

  create_table "investors", force: :cascade do |t|
    t.string "name"
    t.string "team"
    t.bigint "small_investor_category_id"
    t.string "address"
    t.integer "tel"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["small_investor_category_id"], name: "index_investors_on_small_investor_category_id"
  end

  create_table "issuers", force: :cascade do |t|
    t.string "name"
    t.bigint "small_code_id"
    t.string "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["small_code_id"], name: "index_issuers_on_small_code_id"
  end

  create_table "large_codes", force: :cascade do |t|
    t.string "name"
    t.integer "serial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "large_investor_categories", force: :cascade do |t|
    t.string "name"
    t.integer "serial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marketings", force: :cascade do |t|
    t.date "date"
    t.string "marketing"
    t.string "volume"
    t.string "range"
    t.string "strategy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "feedback_id"
    t.string "spread"
    t.string "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_id"], name: "index_orders_on_feedback_id"
  end

  create_table "small_codes", force: :cascade do |t|
    t.string "name"
    t.integer "serial_id"
    t.bigint "large_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["large_code_id"], name: "index_small_codes_on_large_code_id"
  end

  create_table "small_investor_categories", force: :cascade do |t|
    t.string "name"
    t.integer "serial_id"
    t.bigint "large_investor_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["large_investor_category_id"], name: "index_small_investor_categories_on_large_investor_category_id"
  end

  create_table "tranches", force: :cascade do |t|
    t.bigint "deal_id"
    t.bigint "treasury_id"
    t.integer "tenor"
    t.integer "volume"
    t.integer "interest_type"
    t.float "coupon"
    t.integer "restriction"
    t.float "spread"
    t.integer "book_runners", array: true
    t.float "portion"
    t.integer "management_fee"
    t.integer "underwriting_fee"
    t.integer "sales_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_tranches_on_deal_id"
    t.index ["treasury_id"], name: "index_tranches_on_treasury_id"
  end

  create_table "treasuries", force: :cascade do |t|
    t.integer "serial_id"
    t.integer "tenor"
    t.date "issue"
    t.date "maturity"
    t.float "coupon"
    t.integer "payment_per_an"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "underwriters", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_deals", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "deal_id"
    t.boolean "main"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_user_deals_on_deal_id"
    t.index ["user_id"], name: "index_user_deals_on_user_id"
  end

  create_table "user_investors", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "investor_id"
    t.boolean "main"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investor_id"], name: "index_user_investors_on_investor_id"
    t.index ["user_id"], name: "index_user_investors_on_user_id"
  end

  create_table "user_issuers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "issuer_id"
    t.boolean "main"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issuer_id"], name: "index_user_issuers_on_issuer_id"
    t.index ["user_id"], name: "index_user_issuers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "tel"
    t.integer "role"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deals", "deal_categories"
  add_foreign_key "deals", "issuers"
  add_foreign_key "feedbacks", "investors"
  add_foreign_key "feedbacks", "marketings"
  add_foreign_key "investors", "small_investor_categories"
  add_foreign_key "issuers", "small_codes"
  add_foreign_key "orders", "feedbacks"
  add_foreign_key "small_codes", "large_codes"
  add_foreign_key "small_investor_categories", "large_investor_categories"
  add_foreign_key "tranches", "deals"
  add_foreign_key "tranches", "treasuries"
  add_foreign_key "user_deals", "deals"
  add_foreign_key "user_deals", "users"
  add_foreign_key "user_investors", "investors"
  add_foreign_key "user_investors", "users"
  add_foreign_key "user_issuers", "issuers"
  add_foreign_key "user_issuers", "users"
end
