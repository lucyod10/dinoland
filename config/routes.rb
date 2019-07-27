Rails.application.routes.draw do
  get 'users/new'
  root :to => "users#new"
  # get "/users/new" => "users#new"
  resources :users, :only => [:new, :create]
end
