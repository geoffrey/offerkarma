ActiveAdmin.register Comment do
  permit_params :offer, :text, :user

  form title: "Comment" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
