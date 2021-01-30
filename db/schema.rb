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

ActiveRecord::Schema.define(version: 2021_01_30_183306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "battle_id"
    t.bigint "avatar_id"
    t.string "action"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["avatar_id"], name: "index_actions_on_avatar_id"
    t.index ["battle_id"], name: "index_actions_on_battle_id"
  end

  create_table "avatars", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.integer "hp", default: 100
    t.integer "max_hp", default: 100
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "weapon_id"
    t.bigint "armor_id"
    t.index ["armor_id"], name: "index_avatars_on_armor_id"
    t.index ["latitude", "longitude"], name: "location"
    t.index ["user_id"], name: "index_avatars_on_user_id"
    t.index ["weapon_id"], name: "index_avatars_on_weapon_id"
  end

  create_table "battles", force: :cascade do |t|
    t.bigint "avatar1_id"
    t.bigint "avatar2_id"
    t.string "state"
    t.datetime "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["avatar1_id"], name: "index_battles_on_avatar1_id"
    t.index ["avatar2_id"], name: "index_battles_on_avatar2_id"
  end

  create_table "item_drops", force: :cascade do |t|
    t.string "category"
    t.bigint "item_id"
    t.integer "weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_item_drops_on_category"
    t.index ["item_id"], name: "index_item_drops_on_item_id"
  end

  create_table "item_inventories", force: :cascade do |t|
    t.bigint "avatar_id"
    t.bigint "item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["avatar_id"], name: "index_item_inventories_on_avatar_id"
    t.index ["item_id"], name: "index_item_inventories_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "icon_name"
    t.string "asset_name"
    t.string "type"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type", "id"], name: "index_items_on_type_and_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
