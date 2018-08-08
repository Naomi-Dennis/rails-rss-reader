Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/login", to: "users#login", as: "login_user"
  post "/login", to: "users#process_login", as: "process_login"
  get "/logout", to: "users#signout", as: "logout_user"

  
  
  resources :users, only: [:new, :show, :create, :update, :destroy]
  resources :feeds, only: [:index, :create, :update, :edit, :destroy]
  
  resources :articles, only: [:show]
  
  root "welcome#index"
end
