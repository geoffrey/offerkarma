class AddStockGrantValueToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :stock_grant_value, :integer
  end
end
