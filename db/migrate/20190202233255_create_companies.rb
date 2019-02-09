class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name
      t.string :logo_url
      t.boolean :public
      t.string :current_valuation
      t.string :last_funding_round

      t.timestamps
    end
  end
end
