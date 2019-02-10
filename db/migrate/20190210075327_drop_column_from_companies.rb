class DropColumnFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :last_funding_round, :current_valuation
  end
end
