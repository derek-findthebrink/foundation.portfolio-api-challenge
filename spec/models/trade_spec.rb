require 'rails_helper'

RSpec.describe Trade, type: :model do
  it { should belong_to(:portfolio) }
  it { should belong_to(:stock) }

  it { should delegate_method(:symbol).to(:stock) }

  it do
    should define_enum_for(:trade_type)
      .with_values({
                     buy: Trade::BUY,
                     sell: Trade::SELL
                   })
      .backed_by_column_of_type(:enum)
  end

  context 'when a new trade is created' do
    let(:expected_price) { Money.from_cents(100, 'CAD') }
    let(:portfolio) { Portfolio.create! }
    let(:stock) { build(:stock) }
    let(:trade) { build(:trade, price: expected_price, stock: stock) }
    let(:stock_price) { trade.stock.stock_prices.first }

    before do
      portfolio.trades << trade
    end

    it 'should create a stock price with the same price of the trade' do
      expect(stock_price.price).to eq(expected_price)
    end
  end
end
