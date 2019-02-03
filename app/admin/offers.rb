ActiveAdmin.register Offer do
	permit_params :accepted,
		:base_salary,
		:bonus_per_year_amount, 
		:bonus_per_year_percent, 
		:comments_enabled, 
		:company_id, 
		:location,
		:notes,
		:position,
		:public, 
		:relocation_package,
		:type,
		:signon_bonus,
		:user,
		:votes_enabled,
		:yoe
end
