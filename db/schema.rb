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

ActiveRecord::Schema[7.0].define(version: 2025_11_26_231507) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goods", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_goods_on_name", unique: true
  end

  create_table "market_prices", force: :cascade do |t|
    t.bigint "planet_id", null: false
    t.bigint "good_id", null: false
    t.integer "buy_price", null: false
    t.integer "sell_price", null: false
    t.integer "quality", default: 50, null: false
    t.integer "stock", default: 1000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_id"], name: "index_market_prices_on_good_id"
    t.index ["planet_id", "good_id"], name: "index_market_prices_on_planet_id_and_good_id", unique: true
    t.index ["planet_id"], name: "index_market_prices_on_planet_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name", null: false
    t.string "planet_type", null: false
    t.boolean "has_bank", default: false
    t.boolean "has_fixed_quality", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_planets_on_name", unique: true
  end

  create_table "player_inventories", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "good_id", null: false
    t.integer "quantity", default: 0, null: false
    t.integer "quality", default: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_id"], name: "index_player_inventories_on_good_id"
    t.index ["player_id", "good_id"], name: "index_player_inventories_on_player_id_and_good_id", unique: true
    t.index ["player_id"], name: "index_player_inventories_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.integer "reputation", default: 1
    t.integer "credit", default: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_planet_id"
    t.integer "fuel", default: 100
    t.index ["current_planet_id"], name: "index_players_on_current_planet_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "travel_routes", force: :cascade do |t|
    t.bigint "from_planet_id", null: false
    t.bigint "to_planet_id", null: false
    t.integer "fuel_cost", null: false
    t.integer "time_cost", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_planet_id", "to_planet_id"], name: "index_travel_routes_on_from_planet_id_and_to_planet_id", unique: true
    t.index ["from_planet_id"], name: "index_travel_routes_on_from_planet_id"
    t.index ["to_planet_id"], name: "index_travel_routes_on_to_planet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "market_prices", "goods"
  add_foreign_key "market_prices", "planets"
  add_foreign_key "player_inventories", "goods"
  add_foreign_key "player_inventories", "players"
  add_foreign_key "players", "planets", column: "current_planet_id"
  add_foreign_key "players", "users"
  add_foreign_key "travel_routes", "planets", column: "from_planet_id"
  add_foreign_key "travel_routes", "planets", column: "to_planet_id"
end
