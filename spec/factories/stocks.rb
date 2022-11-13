FactoryBot.define do
  factory :stock do
    symbol { SecureRandom.hex(2) }
  end
end
