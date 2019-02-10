# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root to: "pages#index"

  get "stocks", to: "pages#stocks"
  get "negotiate", to: "pages#negotiate"
  get "referrals", to: "pages#stocks"

  get    "login",                    to: "users#login"
  post   "login",                    to: "users#post_login"
  get    "signup",                   to: "users#signup"
  post   "signup",                   to: "users#create"
  delete "logout",                   to: "users#logout"
  get    "account",                  to: "users#account"

  get  "companies/:id",            to: "companies#show"
  get  "companies/:id/offers/new", to: "offers#new"
  post "companies/:id/offers",     to: "offers#create"

  get  "offers",                   to: "offers#index"
  get  "offers/new",               to: "offers#new"
  get  "offers/:id",               to: "offers#show", as: "offer"
  post "offers/:id/votes",         to: "offers#vote", as: "offer_votes"
  post "offers/:id/comments",      to: "offers#comment", as: "offer_comments"

  get "*path", to: redirect("/")
end
