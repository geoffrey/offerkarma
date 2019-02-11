# frozen_string_literal: true

ActiveAdmin.register Offer do
  permit_params :base_salary,
    :bonus_per_year_percent,
    :comments_enabled,
    :company,
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
    :user,
    :votes_enabled,
:yoe
end
