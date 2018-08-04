Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/login", to: "users#login", as: "login_user"
  post "/login", to: "users#process_login", as: "process_login"
  get "/logout", to: "users#signout", as: "logout_user"

  get "/view_feeds", to: "feeds#view_feeds", as: "view_feeds"

  get "/edit_feeds", to: "feeds#edit", as: "edit_feeds"
  
  resources :users, only: [:new, :show, :create, :update, :destroy]
  resources :feeds, only: [:index, :create, :show,  :update, :edit]
  

  root "welcome#index"
end
