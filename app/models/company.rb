class Company < ApplicationRecord
	before_save { url.downcase! }
	before_save { name.downcase! }

	validates_presence_of :name, :url

	has_many :offers
end
