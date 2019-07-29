Rails.application.routes.draw do
  root :to => "pages#home"
  resources :users
  get "/session/characters" => "session#characters"
  get "/session/species" => "session#species"
  get "/session/accessories" => "session#accessories"
  resources :characters
  resources :species
  resources :accessories
  get "/login" => "session#new" # find the session of that browser. unique to each person.
  post "/login" => "session#create"
  delete "/login" => "session#destroy"
  get "/coins" => "session#coins"
  post "/coins/add" => "session#add_coins"
end
