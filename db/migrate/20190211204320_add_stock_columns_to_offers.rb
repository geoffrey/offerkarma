class AddStockColumnsToOffers < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :bonus_per_year_amount, :integer
    add_column :offers, :stock_type, :integer
    add_column :offers, :stock_count, :integer
    add_column :offers, :stock_strike_price, :float
    add_column :offers, :stock_fair_market_value, :float
  end
end
