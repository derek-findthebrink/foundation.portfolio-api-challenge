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

thnc = Stock.create(symbol: 'thnc')
bmo = Stock.create(symbol: 'bmo')
noodle = Stock.create(symbol: 'noodle')

thnc.stock_prices.create(price: price_in_dollars(1.74), time: Time.current - 1.day)
bmo.stock_prices.create(price: price_in_dollars(29.0), time: Time.current - 2.days)
noodle.stock_prices.create(price: price_in_dollars(55.0), time: Time.current - 3.days + 4.hours)

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
