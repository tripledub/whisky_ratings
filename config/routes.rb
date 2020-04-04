Rails.application.routes.draw do
  root to: 'whiskey#index'

  resources :whiskey, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :whiskeys
    end
  end
end
