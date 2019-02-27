Rails.application.routes.draw do

  root "news#index"

  get "/favorites", to: "favorites#index", as: "favorites"
  post "/favorites", to: "favorites#create", as: "add_favorite"
  delete "/favorites", to: "favorites#destroy", as: "delete_favorite"
  
end
