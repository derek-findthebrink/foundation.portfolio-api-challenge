require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  it { should have_many(:trades) }
end
