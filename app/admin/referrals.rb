# frozen_string_literal: true

ActiveAdmin.register Referral do
  permit_params :company_id,
    :created_at,
    :email,
    :first_name,
    :job_posting_url,
    :last_name,
    :linkedin_profile_url,
    :location,
    :phone,
    :position,
    :referred,
    :referred_at,
    :referrer_id,
    :updated_at,
    :user_id,
    :yoe

  form title: "Referral" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
