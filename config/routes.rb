Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login',
                                             sign_out: 'logout',
                                             edit: '/users/do/edit' }

  resources :chatrooms do
    resources :broadcasts
  end

  resources :users, only: [:show]
  resources :games

  root 'chatrooms#index'
end
