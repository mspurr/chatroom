Rails.application.routes.draw do
  devise_for :users
  resources :chatrooms

  root 'chatrooms#index'
end
