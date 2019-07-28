Rails.application.routes.draw do
  root :to => "pages#home"
  resources :users, :only => [:new, :create, :edit, :update, :index]
  get "/session/characters" => "session#characters"
  resources :characters
  get "/login" => "session#new" # find the session of that browser. unique to each person.
  post "/login" => "session#create"
  delete "/login" => "session#destroy"
end
