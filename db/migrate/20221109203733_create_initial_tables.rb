class CreateInitialTables < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.timestamps
    end

    create_table :stocks do |t|
      t.string :symbol, null: false
      t.timestamps
    end

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

    # TODO: add indexes
  end
end
