require 'rails_helper'

RSpec.describe Portfolios::UpdateTradeForm do
  let(:portfolio) { Portfolio.create! }
  let(:symbol) { 'bmo' }
  let(:stock) { create(:stock, symbol: symbol) }
  let(:quantity) { 100 }
  let(:price) { 10 }
  let(:params) do
    {
      id: nil,
      symbol: symbol,
      trade_type: Trade::SELL,
      quantity: quantity,
      price: price
    }.stringify_keys
  end
  let(:pre_existing_trade_params) { params.except('id', 'symbol').merge(stock: stock) }

  let(:time) { Time.current - 1.hour }

  let(:instance) { Portfolios::UpdateTradeForm.new(portfolio, params) }

  describe '#result' do
    subject { instance.result }

    context 'when the trade exists' do
      before do
        trade = portfolio.trades.create!(pre_existing_trade_params)
        params['id'] = trade.id
      end

      it 'has success eq to true' do
        expect(subject.success).to eq(true)
      end

      it 'has a trade' do
        expect(subject.trade).to be_instance_of(Trade)
      end

      it 'has the price of the trade set as expected' do
        expect(subject.trade.price).to eq(Money.from_amount(price, 'CAD'))
      end
    end

    context 'when the stock symbol does not exist' do
      # NOTE: by never calling `stock` in this block, we ensure that
      # the stock doesn't already exist before the form executes
      subject { instance.result.trade.stock }

      let(:new_symbol) { "I'm a fake symbol" }

      before do
        trade = portfolio.trades.create!(pre_existing_trade_params)
        params['id'] = trade.id
        params['symbol'] = new_symbol
      end

      it 'creates a new stock for that symbol' do
        expect(subject).to be_instance_of(Stock)
        expect(subject.symbol).to eq(new_symbol)
      end
    end

    context 'when the trade fails to save' do
      before do
        allow_any_instance_of(Trade).to receive(:persisted?).and_return(false)
      end

      it 'has success eq to false' do
        expect(subject.success).to eq(false)
      end
    end

    context 'when the trade does not exist' do
      before do
        Portfolio.create!
      end

      it 'has success eq to false' do
        expect(subject.success).to eq(false)
      end
    end
  end
end
