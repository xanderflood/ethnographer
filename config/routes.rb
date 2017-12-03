Rails.application.routes.draw do
  root to: 'cultures#index'

  resources :cultures
  resources :units

  resources :unit_types
end
