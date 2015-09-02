Rails.application.routes.draw do
  resources :chatrooms

  root 'chatrooms#index'
end
