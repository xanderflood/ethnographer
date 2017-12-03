Rails.application.routes.draw do
  root to: 'cultures#index'

  resources :cultures
  resources :unit_types
end
