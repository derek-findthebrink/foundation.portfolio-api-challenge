class PortfolioReport
  def initialize(portfolio)
    @portfolio = portfolio
  end

  attr_reader :portfolio

  def holdings
    {
      thnc: {
        quantity: 120,
        average_cost: '$10.00',
        cost_basis: '$1200',
        current_value: '$100',
        unrealized_gain_or_loss: '($1100)'
      }
    }
  end
end
