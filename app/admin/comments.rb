ActiveAdmin.register Comment do
  permit_params :content, :offer, :user

  form title: "Comment" do |f|
    f.inputs :except => [:uuid]
    f.actions
  end
end
