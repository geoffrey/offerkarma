# frozen_string_literal: true

ActiveAdmin.register Company do
   permit_params :domain,
    :name,
    :public,
    :symbol

  form title: "Company" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
