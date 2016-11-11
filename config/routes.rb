Rails.application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omni_auth_callbacks"}
  root 'search#index'
  get '/guestbook' => 'guestbook#index', :as => :guestbook
  get '/logout' => 'session#logout', :as => :logout
  get '/login' => 'session#login', :as => :login
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
