# frozen_string_literal: true

ActiveAdmin.register Company do
   permit_params :domain,
    :name,
    :public,
    :quote,
    :symbol,
    :vesting_schedule

  index do
    selectable_column

    Company.column_names.each do |c|
      column c.to_sym
    end

    actions do |company|
      item "View on site", company_path(company.uuid), target: "_blank"
    end
  end

  form title: "Company" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
