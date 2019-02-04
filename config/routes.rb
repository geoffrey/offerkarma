Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  
	root to: "offers#index"

	get  "login",                    to: "users#login"
	post "login",                    to: "users#post_login"

  get  "companies/:id",            to: "companies#show"
  get  "companies/:id/offers/new", to: "offers#new"
  post "companies/:id/offers",     to: "offers#create"
  
  get  "offers",                   to: "offers#index"
  get  "offers/new",               to: "offers#new"
  get  "offers/:id",               to: "offers#show", as: "offer"
  post "offers/:id/votes",         to: "offers#votes"
end
