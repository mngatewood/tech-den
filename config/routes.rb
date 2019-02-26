Rails.application.routes.draw do

  root "news#index"

  post "/favorites", to: "favorites#create", as: "add_favorite"
  
end
