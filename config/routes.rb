Rails.application.routes.draw do
  root to: 'whiskey#index'

  resources :whiskey, only: [:index]
end
