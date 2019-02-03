ActiveAdmin.register Company do
	permit_params :current_valuation,
		:last_funding_round,
		:name,
		:public,
		:url
end
