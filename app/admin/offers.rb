# frozen_string_literal: true

ActiveAdmin.register Offer do
  index do
  end
  permit_params :accepted,
                :base_salary,
                :bonus_per_year_amount,
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
                :status,
                :user_id,
                :votes_enabled,
                :yoe
end
