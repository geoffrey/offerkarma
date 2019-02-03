class AddColumnsToOffer < ActiveRecord::Migration[5.2]
  def change
  	add_column :offers, :yoe, :decimal
  	add_column :offers, :location, :string
  	add_column :offers, :type, :string
  end
end
