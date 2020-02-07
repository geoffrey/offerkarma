Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "(*any)", to: redirect(ENV.fetch("OFFERKARMA_BASE_URL")),
                constraints: ->(request) { request.subdomain == "www" }

  get "(*any)", to: redirect(ENV.fetch("OFFERKARMA_BASE_URL")),
                constraints: ->(request) { request.domain == ENV.fetch("SECOND_DOMAIN") }

  ActiveAdmin.routes(self)

  root to: "pages#index"

  get "equity",    to: "pages#equity"
  get "negotiate", to: "pages#negotiate"

  get "terms-of-service", to: "pages#terms"
  get "privacy-policy",   to: "pages#privacy"

  get    "login",                    to: "users#login"
  post   "login",                    to: "users#post_login"
  get    "signup",                   to: "users#signup"
  post   "signup",                   to: "users#create"
  delete "logout",                   to: "users#logout"
  get    "account",                  to: "users#account"
  get    "verify/:token",            to: "users#verify", as: :verify

  get    "unsubscribe",              to: "emails#show"
  patch  "unsubscribe",              to: "emails#update"

  resources :companies, only: [:show]
  resources :referrals
  resources :offers do
    member do
      post :votes
      post :comments
    end
  end
end
