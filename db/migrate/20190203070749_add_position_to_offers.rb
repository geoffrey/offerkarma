class AddPositionToOffers < ActiveRecord::Migration[5.2]
  def change
  	add_column :offers, :position, :string
  end
end
