Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:new, :create, :index]
  resources :players do
    member do
      post :travel
      post 'goods/:good_id/buy', to: 'player/goods#buy', as: :buy_good
      post 'goods/:good_id/sell', to: 'player/goods#sell', as: :sell_good
    end
  end
end
