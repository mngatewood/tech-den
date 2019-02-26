Rails.application.routes.draw do

  root "news#index"

  post "/favorites", to: "favorites#create", as: "add_favorite"
  get "/favorites", to: "favorites#index", as: "favorites"
  
end
