# frozen_string_literal: true

ActiveAdmin.register Vote do
  permit_params :offer_id, :vote
end
