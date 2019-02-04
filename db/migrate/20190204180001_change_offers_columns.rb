class ChangeOffersColumns < ActiveRecord::Migration[5.2]
  def change
  	remove_column :offers, :accepted, :boolean
  	remove_column :offers, :public
  	add_column :offers, :status, :string
  	add_column :offers, :scope, :string
  	rename_column :offers, :type, :offer_type
  end
end
