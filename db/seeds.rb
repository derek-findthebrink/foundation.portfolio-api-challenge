# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

portfolio = Portfolio.new
portfolio.save

def price_in_dollars(amount)
  Money.from_amount(amount, 'CAD')
end

stocks = [
  thnc = Stock.create(symbol: 'thnc'),
  bmo = Stock.create(symbol: 'bmo'),
  noodle = Stock.create(symbol: 'noodle')
]

thnc.stock_prices.create(price: price_in_dollars(1.20), time: Time.current - 2.days)
bmo.stock_prices.create(price: price_in_dollars(29.0), time: Time.current - 2.days)
noodle.stock_prices.create(price: price_in_dollars(55.0), time: Time.current - 2.days)

thnc.stock_prices.create(price: price_in_dollars(1.74), time: Time.current - 1.day)
bmo.stock_prices.create(price: price_in_dollars(31.0), time: Time.current - 1.day)
noodle.stock_prices.create(price: price_in_dollars(57.0), time: Time.current - 1.day)

portfolio.trades.create(
  stock: thnc, trade_type: :buy, time: Time.current,
  quantity: 500, price: price_in_dollars(2)
)
portfolio.trades.create(
  stock: bmo, trade_type: :buy, time: Time.current,
  quantity: 1200, price: price_in_dollars(30)
)
portfolio.trades.create(
  stock: noodle, trade_type: :buy, time: Time.current,
  quantity: 50, price: price_in_dollars(56)
)

# Random trades to help with testing holdings report
# TODO: change to something nicer in prod
trade_types = %i[buy sell]
time_range = ((Time.current - 10.days)..Time.current)
quantity_range = (10..1000)

stocks.each do |stock|
  rand(10..25).times do
    trade = portfolio.trades.create(
      stock: stock, trade_type: trade_types.sample, time: rand(time_range),
      quantity: rand(quantity_range), price: price_in_dollars(rand(1.5..56.00))
    )
    puts ['Trade created!', trade.symbol, trade.trade_type, trade.quantity, trade.price.format].inspect
  end
end
