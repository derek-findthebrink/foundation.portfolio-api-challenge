require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should have_many(:stock_prices) }
end
