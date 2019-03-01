class RenameStockFairMarketValue < ActiveRecord::Migration[5.2]
  def change
    rename_column :offers, :stock_fair_market_value, :stock_preferred_price
  end
end
