class Company < ApplicationRecord
	REFFO_COMPANY_ID=1
	
	before_save { url.downcase! }
	before_save { name.downcase! }

	validates_presence_of :name, :url

	has_many :offers
end
