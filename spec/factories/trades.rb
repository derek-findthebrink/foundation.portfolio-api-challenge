FactoryBot.define do
  factory :trade do
    trade_type { Trade::BUY }
    quantity { 10 }
    time { Time.current }
    price { 10 }
  end
end
