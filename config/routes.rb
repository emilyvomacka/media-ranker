Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  get "/works/:id/upvote", to: "works#upvote", as: "upvote_work"
  resources :works 

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user" 
  get "/users/:id", to: "users#show", as: "user"
end
