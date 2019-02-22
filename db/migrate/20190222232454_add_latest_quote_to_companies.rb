class AddLatestQuoteToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :quote, :float
    remove_column :companies, :public, :boolean
  end
end
