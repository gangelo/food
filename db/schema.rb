# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_14_121952) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "item_name", limit: 64, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((item_name)::text)", name: "index_items_on_lower_item_name", unique: true
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.string "shopping_list_name", limit: 64, default: "", null: false
    t.date "week_of"
    t.text "notes"
    t.boolean "template", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopping_list_name", "week_of"], name: "index_shopping_lists_on_shopping_list_name_and_week_of", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "state_name", limit: 14, default: "", null: false
    t.string "postal_abbreviation", limit: 2, default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["postal_abbreviation"], name: "index_states_on_postal_abbreviation", unique: true
    t.index ["state_name"], name: "index_states_on_state_name", unique: true
  end

  create_table "stores", force: :cascade do |t|
    t.bigint "state_id"
    t.string "store_name", limit: 64, default: "", null: false
    t.string "address", limit: 64, default: "", null: false
    t.string "address2", limit: 64
    t.string "city", limit: 64, default: "", null: false
    t.string "zip_code", limit: 10, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_stores_on_state_id"
    t.index ["store_name", "zip_code"], name: "index_stores_on_store_name_and_zip_code", unique: true
  end

  create_table "user_shopping_list_items", force: :cascade do |t|
    t.bigint "user_shopping_list_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_user_shopping_list_items_on_item_id"
    t.index ["user_shopping_list_id"], name: "index_user_shopping_list_items_on_user_shopping_list_id"
  end

  create_table "user_shopping_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shopping_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopping_list_id"], name: "index_user_shopping_lists_on_shopping_list_id"
    t.index ["user_id"], name: "index_user_shopping_lists_on_user_id"
  end

  create_table "user_stores", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_user_stores_on_store_id"
    t.index ["user_id", "store_id"], name: "index_user_stores_on_user_id_and_store_id", unique: true
    t.index ["user_id"], name: "index_user_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 64, default: "", null: false
    t.string "last_name", limit: 64, default: "", null: false
    t.string "username", limit: 64, default: "", null: false
    t.string "email", limit: 320, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "stores", "states"
  add_foreign_key "user_shopping_list_items", "items"
  add_foreign_key "user_shopping_list_items", "user_shopping_lists"
  add_foreign_key "user_shopping_lists", "shopping_lists"
  add_foreign_key "user_shopping_lists", "users"
  add_foreign_key "user_stores", "stores"
  add_foreign_key "user_stores", "users"
end
