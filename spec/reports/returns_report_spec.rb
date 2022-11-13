require 'rails_helper'

RSpec.describe ReturnsReport do
  let(:portfolio) { Portfolio.create! }

  let(:instance) { ReturnsReport.new(portfolio) }

  before do
    stocks = create_list(:stock, 3)
    stocks.each do |stock|
      create(:trade, price: 15, quantity: 10, trade_type: Trade::BUY, stock: stock, portfolio: portfolio)
      create(:trade, price: 25, quantity: 10, trade_type: Trade::BUY, stock: stock, portfolio: portfolio)
      create(:stock_price, stock: stock, price: 25)
    end
  end

  describe '#result' do
    subject { instance.result }

    it 'has success eq to true' do
      expect(subject.success).to eq(true)
    end

    it do
      # TODO: complete tests
    end
  end
end
