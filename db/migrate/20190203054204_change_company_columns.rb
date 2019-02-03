class ChangeCompanyColumns < ActiveRecord::Migration[5.2]
  def change
  	rename_column :companies, :logo_url, :url
  end
end
