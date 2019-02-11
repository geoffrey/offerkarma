# frozen_string_literal: true

ActiveAdmin.register Offer do
  permit_params :accepted,
                :base_salary,
                :bonus_per_year_percent,
                :comments_enabled,
                :company_id,
                :location,
                :level,
                :notes,
                :position,
                :public,
                :relocation_package,
                :type,
                :signon_bonus,
                :scope,
                :share_fmv,
                :status,
                :stock_option_stike_price,
                :stock_type,
                :user_id,
                :votes_enabled,
                :yoe
end
