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

    describe 'returns' do
      subject { instance.result.returns }

      it 'has the expected number of returns' do
        expect(subject.size).to eq(3)
      end

      describe 'return entry' do
        subject { instance.result.returns.first }

        it 'has the expected total_purchase_cost_cents' do
          expect(subject.total_purchase_cost_cents).to eq(40_000)
        end

        it 'has the expected current_market_price_cents' do
          expect(subject.current_market_price_cents).to eq(2500)
        end

        it 'has the expected current_holding_value_cents' do
          expect(subject.current_holding_value_cents).to eq(50_000)
        end

        it 'has the expected net_return_cents' do
          expect(subject.net_return_cents).to eq(10_000)
        end
      end
    end
  end
end
