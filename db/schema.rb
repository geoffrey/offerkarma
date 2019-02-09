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

ActiveRecord::Schema.define(version: 2019_02_06_043441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offer_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["offer_id"], name: "index_comments_on_offer_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.boolean "public"
    t.string "current_valuation"
    t.string "last_funding_round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.boolean "comments_enabled"
    t.boolean "votes_enabled"
    t.integer "base_salary"
    t.integer "signon_bonus"
    t.integer "relocation_package"
    t.text "notes"
    t.integer "bonus_per_year_amount"
    t.integer "bonus_per_year_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "yoe"
    t.string "location"
    t.string "offer_type"
    t.string "position"
    t.uuid "user_id"
    t.string "status"
    t.string "scope"
    t.string "level"
    t.index ["company_id"], name: "index_offers_on_company_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "username"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "current_company_id"
    t.string "password_digest"
    t.index ["current_company_id"], name: "index_users_on_current_company_id"
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offer_id"
    t.integer "vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["offer_id"], name: "index_votes_on_offer_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "offers"
  add_foreign_key "offers", "companies"
  add_foreign_key "votes", "offers"
end
