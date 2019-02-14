# frozen_string_literal: true

ActiveAdmin.register User do
  actions :all, except: [:new, :create, :edit, :update, :destroy]
end
