require 'rails_helper'

RSpec.describe HoldingsReport do
  let(:portfolio) { Portfolio.create! }

  let(:instance) { HoldingsReport.new(portfolio) }

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

    it 'has an entry for each holding' do
      expect(subject.holdings.size).to eq(3)
    end

    describe 'holdings entry' do
      subject { instance.result.holdings.first }

      it 'has the correct quantity' do
        expect(subject[:signed_quantity]).to eq(20)
      end

      it 'has the expected average price' do
        expect(subject[:average_price_cents]).to eq(2000)
      end
    end

    context 'when a holding has been completely sold' do
      subject { instance.result.holdings }

      let(:stock) { Stock.first }

      before do
        create(:trade, portfolio: portfolio, stock: stock,
                       trade_type: Trade::SELL, quantity: 25, price: 25)
      end

      it 'is not present in the holdings list' do
        expect(subject.find { |holding| holding[:symbol] == stock.symbol })
          .to be_falsy
      end
    end

    context 'when a holding has been partially sold' do
      subject { instance.result.holdings }

      let(:stock) { Stock.first }
      let(:holding) { subject.find { |holding| holding[:symbol] == stock.symbol } }

      before do
        create(:trade, portfolio: portfolio, stock: stock,
                       trade_type: Trade::SELL, quantity: 10, price: 25)
      end

      it 'is present in the holdings list' do
        expect(holding).to be_present
      end

      it 'has the expected quantity' do
        expect(holding[:signed_quantity]).to eq(10)
      end

      it 'has the expected average price' do
        expect(holding[:average_price_cents]).to eq(2000)
      end
    end
  end
end
