Rails.application.routes.draw do
  root 'users#index'

  resources :users do
    resources :players, only: %i[index new create]
  end

  resources :players, only: [] do
    member do
      get :inventory_summary
    end
  end

  resources :players, only: [:show] do
    member do
      post :travel
      post :refuel
      post :restart
      post 'buy/:good_id', to: 'players#buy_good', as: :buy_good
      post 'sell/:good_id', to: 'players#sell_good', as: :sell_good
    end
  end
end
