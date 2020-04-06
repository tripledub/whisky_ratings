Rails.application.routes.draw do
  root to: 'whiskey#index'

  resources :whiskey, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :whiskeys do
        get :search, on: :collection
      end
    end
  end
end
