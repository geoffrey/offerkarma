class AddSymbolToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :symbol, :string
  end
end
