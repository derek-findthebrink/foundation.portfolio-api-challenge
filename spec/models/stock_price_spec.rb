require 'rails_helper'

RSpec.describe StockPrice, type: :model do
  it { should belong_to(:stock) }
  it { should delegate_method(:symbol).to(:stock) }

  describe '#most_recent_prices_by_stock' do
    subject { StockPrice.most_recent_prices_by_stock }

    let(:expected_time) { Time.parse('2030-11-11T00:00:00') }
    let(:unexpected_time) { Time.parse('2020-11-11T00:00:00') }
    let(:expected_price) { Money.from_cents(1500, 'CAD') }
    let(:stocks) { create_list(:stock, stocks_count) }

    before do
      stocks.each do |stock|
        create_list(:stock_price, 2, stock: stock, price: [1, 2, 3].sample, time: unexpected_time)
        create(:stock_price, stock: stock, price: expected_price, time: expected_time)
      end
    end

    context 'when there is one stock' do
      let(:stocks_count) { 1 }

      it 'returns the most recent stock price for a stock' do
        target = subject.where(stock: stocks).first
        expect(target.price).to eq(expected_price)
      end

      it 'returns only one stock price' do
        expect(subject.size).to eq(1)
      end
    end

    context 'when there is more than one stock' do
      let(:stocks_count) { 5 }

      it 'returns only as many stocks as have stock prices' do
        expect(subject.size).to eq(stocks_count)
      end
    end
  end
end
