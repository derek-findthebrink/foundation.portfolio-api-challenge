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

ActiveRecord::Schema[7.0].define(version: 2022_11_09_203733) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "trade_types", ["BUY", "SELL"]

  create_table "portfolios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_prices", force: :cascade do |t|
    t.datetime "time", comment: "The time that the price was set on the market"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "CAD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stock_id"
    t.index ["stock_id"], name: "index_stock_prices_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "symbol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_stocks_on_symbol", unique: true
  end

  create_table "trades", force: :cascade do |t|
    t.enum "trade_type", null: false, enum_type: "trade_types"
    t.decimal "quantity", null: false
    t.datetime "time", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "CAD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "portfolio_id"
    t.bigint "stock_id"
    t.index ["portfolio_id"], name: "index_trades_on_portfolio_id"
    t.index ["stock_id"], name: "index_trades_on_stock_id"
  end

  add_foreign_key "stock_prices", "stocks"
  add_foreign_key "trades", "portfolios"
  add_foreign_key "trades", "stocks"
end
