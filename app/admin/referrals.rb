# frozen_string_literal: true

ActiveAdmin.register Referral do
  actions :all, except: [:new, :create, :edit, :update, :destroy]
end
