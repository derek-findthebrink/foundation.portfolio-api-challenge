# Structures all of the initial database types required by the DB
#
# I'm using one migration file for everything here as opposed to using multiple
# files because it helps me speed up iterating on different data structures as
# the project comes together. As soon as the project goes to production / any
# non-ephemeral environment, then I would always create new migration files for
# each table in order to:
# - avoid damaging the migrations process
# - avoid damaging live data
# - avoid annoying my teammates :D
class CreateInitialTables < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.timestamps
    end

    create_table :stocks do |t|
      t.string :symbol, null: false
      t.timestamps
    end

    # NOTE: constraining the DB to only allow unique stock symbols
    add_index :stocks, :symbol, unique: true

    create_table :stock_prices do |t|
      t.datetime :time, comment: 'The time that the price was set on the market'
      t.monetize :price, null: false
      t.timestamps
    end

    # NOTE: the values of these enums CANNOT BE CHANGED without also altering the DB
    create_enum :trade_types, [Trade::BUY, Trade::SELL]

    create_table :trades do |t|
      t.enum :trade_type, enum_type: 'trade_types', null: false
      t.numeric :quantity, null: false
      t.datetime :time, null: false
      t.monetize :price, null: false
      t.timestamps
    end

    add_belongs_to :trades, :portfolio, foreign_key: true
    add_belongs_to :trades, :stock, foreign_key: true
    add_belongs_to :stock_prices, :stock, foreign_key: true

    # TODO: add common query indexes
  end
end
