class RenameUrlToDomainInCompanies < ActiveRecord::Migration[5.2]
  def change
    rename_column :companies, :url, :domain
  end
end
