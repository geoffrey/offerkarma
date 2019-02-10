# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root to: "pages#index"

  get "equity",    to: "pages#equity"
  get "negotiate", to: "pages#negotiate"
  get "referrals", to: "pages#referrals"

  get    "login",                    to: "users#login"
  post   "login",                    to: "users#post_login"
  get    "signup",                   to: "users#signup"
  post   "signup",                   to: "users#create"
  delete "logout",                   to: "users#logout"
  get    "account",                  to: "users#account"

  resources :companies, only: [:show] do
    resources :offers, only: %i[new create]
  end

  resources :offers, only: %i[index new show edit update] do
    member do
      post :vote
      post :comments
    end
  end
end
