Rails.application.routes.draw do
  get 'portfolio', to: 'portfolios#index'

  namespace :portfolios, path: 'portfolio' do
    get 'returns', to: 'returns#index'
    get 'holdings', to: 'holdings#index'

    resources :trades, only: %i[create update destroy]
  end
end
