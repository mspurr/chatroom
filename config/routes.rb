Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login',
                                             sign_out: 'logout',
                                             edit: '/users/do/edit' }

  resources :chatrooms do
    resources :broadcasts do
      member do
        get :like, to: 'broadcasts#like'
        get :unlike, to: 'broadcasts#unlike'
      end
    end
  end

  resources :user_friendships do
    member do
      put :accept
    end
  end

  resources :users, only: [:show, :profile]
  resources :games

  get '/users/do/profile', to: 'users#profile', as: 'profile'

  root 'chatrooms#home'
end
