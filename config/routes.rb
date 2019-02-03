Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  
	root to: "offers#index"
  
  resources :offers
  post "/offers/:id/votes", to: "offers#votes"

  resources :companies do 
  	resources :offers
  end
end
