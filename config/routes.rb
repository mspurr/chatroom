Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login',
                                             sign_out: 'logout',
                                             edit: '/users/do/edit' }

  resources :chatrooms do
    resources :broadcasts do
      member do
        put :like, to: 'broadcasts#like'
        put :unlike, to: 'broadcasts#unlike'
      end
    end
  end

  resources :users, only: [:show, :profile]
  resources :games

  get '/users/do/profile', to: 'users#profile', as: 'profile'

  root 'chatrooms#home'
end
