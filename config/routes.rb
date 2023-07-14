Rails.application.routes.draw do
  #get 'microposts/new'
  #get 'microposts/index'
  #get 'sessions/new'
 # root "static_pages#home"
  #get  "/help",    to: "static_pages#help"
  #get "/signup", to: "users#new"
  #get "/login", to: "sessions#new"
  #get "/microposts", to: "microposts#index"
  #post "login", to: "sessions#create"
  #delete "/logout", to: "sessions#destroy"
  resources :users, only: [:index, :new, :create]
  #resources :account_activations, only: [:edit]
  #resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:new, :create, :index, :destroy]
end