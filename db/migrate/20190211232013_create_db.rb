class CreateDb < ActiveRecord::Migration[5.2]
  def change
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
      t.boolean "public"
      t.string "current_valuation"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
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
      t.decimal "yoe"
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
      t.index ["company_id"], name: "index_offers_on_company_id"
      t.index ["user_id"], name: "index_offers_on_user_id"
    end

    create_table "users", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }
      t.text "username"
      t.text "email"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "current_company_id"
      t.string "password_digest"
      t.string "confirmation_digest"
      t.datetime "confirmed_at"
      t.index ["current_company_id"], name: "index_users_on_current_company_id"
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
end
