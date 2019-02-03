ActiveAdmin.register Offer do
	permit_params :company_id, :public, :comments_enabled, :votes_enabled, :base_salary

end
