# frozen_string_literal: true

ActiveAdmin.register Offer do
  permit_params :base_salary,
    :bonus_per_year_percent,
    :comments_enabled,
    :company_id,
    :location,
    :level,
    :notes,
    :position,
    :relocation_package,
    :type,
    :signon_bonus,
    :scope,
    :status,
    :stock_count,
    :stock_fair_market_value,
    :stock_type,
    :stock_strike_price,
    :user_id,
    :votes_enabled,
    :yoe

  form title: "Offer" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
