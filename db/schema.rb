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

ActiveRecord::Schema.define(version: 2020_02_13_004053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.bigint "offer_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["offer_id"], name: "index_comments_on_offer_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "name"
    t.string "domain"
    t.string "current_valuation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.float "quote"
    t.integer "vesting_schedule"
  end

  create_table "offers", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.bigint "company_id"
    t.boolean "comments_enabled"
    t.boolean "votes_enabled"
    t.integer "base_salary"
    t.integer "signon_bonus"
    t.integer "relocation_package"
    t.text "notes"
    t.integer "bonus_per_year_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "yoe"
    t.string "location"
    t.string "position"
    t.bigint "user_id"
    t.string "level"
    t.integer "scope"
    t.integer "status"
    t.integer "stock_type"
    t.integer "stock_count"
    t.float "stock_strike_price"
    t.float "stock_preferred_price"
    t.integer "vesting_schedule"
    t.integer "stock_grant_value"
    t.integer "fairness_score"
    t.integer "competitiveness_score"
    t.index ["company_id"], name: "index_offers_on_company_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.bigint "user_id"
    t.bigint "referrer_id"
    t.bigint "company_id"
    t.string "position"
    t.string "location"
    t.boolean "referred"
    t.datetime "referred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "yoe"
    t.string "job_posting_url"
    t.string "linkedin_profile_url"
    t.string "phone"
    t.string "email"
    t.datetime "unlocked_at"
    t.datetime "referrer_referred_at"
    t.datetime "referee_referred_at"
    t.index ["company_id"], name: "index_referrals_on_company_id"
    t.index ["referrer_id"], name: "index_referrals_on_referrer_id"
    t.index ["user_id"], name: "index_referrals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.text "username"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "verification_digest"
    t.datetime "verified_at"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.bigint "offer_id"
    t.integer "vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["offer_id"], name: "index_votes_on_offer_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "offers"
  add_foreign_key "offers", "companies"
  add_foreign_key "votes", "offers"
end
