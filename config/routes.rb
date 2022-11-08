Rails.application.routes.draw do
  get 'portfolio', to: 'portfolio#index'

  namespace :portfolio do
    get 'returns', to: 'returns#index'
    get 'holdings', to: 'holdings#index'
  end
end
