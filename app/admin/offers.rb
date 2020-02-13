# frozen_string_literal: true

ActiveAdmin.register Offer do
  scope :all, default: true
  scope :pending
  scope :accepted
  scope :declined

  permit_params :base_salary,
    :bonus_per_year_percent,
    :comments_enabled,
    :company_id,
    :competitiveness_score,
    :fairness_score,
    :level,
    :location,
    :notes,
    :position,
    :relocation_package,
    :scope,
    :signon_bonus,
    :status,
    :stock_count,
    :stock_grant_value,
    :stock_preferred_price,
    :stock_strike_price,
    :stock_type,
    :type,
    :user_id,
    :vesting_schedule,
    :votes_enabled,
    :yoe


  index do
    selectable_column
    id_column
    column :user
    column :status
    column :company
    column :location
    column :position
    column :level
    column :yoe
    column :base_salary do |offer|
      number_to_human offer.base_salary
    end
    column :signon_bonus do |offer|
      number_to_human offer.signon_bonus
    end
    column :relocation_package do |offer|
      number_to_human offer.relocation_package
    end
    column :bonus_per_year_percent
    column :vesting_schedule
    column :stock_type
    column :stock_count
    column :stock_strike_price
    column :stock_preferred_price
    column :stock_grant_value
    column :created_at
    column :updated_at

    actions do |offer|
      item "View on site", offer_path(offer.uuid), target: "_blank"
    end
  end

  form title: "Offer" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
