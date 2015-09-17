Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => '/users/do/edit'}
  resources :chatrooms do
  	resources :broadcasts do
  		resources :comments
  	end
  end
  resources :users, only: [:show]

  root 'chatrooms#index'
end
