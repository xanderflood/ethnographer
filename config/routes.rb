Rails.application.routes.draw do
  root to: 'cultures#index'

  resources :cultures
end
