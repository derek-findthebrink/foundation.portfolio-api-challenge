require 'rails_helper'

RSpec.describe Portfolios::CreateTradeForm do
  let(:portfolio) { Portfolio.create! }
  let(:symbol) { 'bmo' }
  let(:quantity) { 100 }
  let(:price) { 10 }
  let(:params) do
    {
      symbol: symbol,
      trade_type: Trade::SELL,
      quantity: quantity,
      price: price
    }.stringify_keys
  end

  let(:time) { Time.current - 1.hour }

  let(:instance) { Portfolios::CreateTradeForm.new(portfolio, params) }

  describe '#result' do
    subject { instance.result }

    it 'has success eq to true' do
      expect(subject.success).to eq(true)
    end

    it 'has a trade' do
      expect(subject.trade).to be_instance_of(Trade)
    end

    context 'when the stock symbol does not exist' do
      let(:stock) { Stock.find_by_symbol(symbol) }

      before do
        subject
      end

      it 'creates a new stock for that symbol' do
        expect(stock).to be_instance_of(Stock)
        expect(stock.symbol).to eq(symbol)
      end
    end

    context 'when the trade fails to save' do
      it 'has success eq to false' do
        allow_any_instance_of(Trade).to receive(:persisted?).and_return(false)
        expect(subject.success).to eq(false)
      end
    end
  end
end
