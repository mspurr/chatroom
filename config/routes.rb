Rails.application.routes.draw do
  resources :comments
  devise_for :users, path: '', path_names: { sign_in: 'login',
                                             sign_out: 'logout',
                                             edit: '/users/do/edit' }

  resources :chatrooms do
    member do
      put :favorite
    end
    resources :broadcasts do
      member do
        get :like, to: 'broadcasts#like'
        get :unlike, to: 'broadcasts#unlike'
      end
      resources :comments do
        member do
          get :like, to: 'comments#like'
          get :unlike, to: 'comments#unlike'
        end
      end
    end
  end

  resources :friendships, only: [:create, :destroy, :accept] do 
    member do 
      put :accept
    end
  end
  
  resources :users, only: [:show, :profile, :index]
  
  resources :games do
    member do
      put :favorite
    end
  end

  resources :searching, path: '/search' do
    collection do
      get :autocomplete
    end
  end

  get '/users/do/profile', to: 'users#profile', as: 'profile'
  get '/tags/:tag', to: 'chatrooms#home', as: :tag

  root 'chatrooms#home'
end
