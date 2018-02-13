Rails.application.routes.draw do
  root to: 'transfers#index'

  resources :transfers, only: [:new, :index, :create, :destroy]
end
