class RemoveNamesFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :text
    remove_column :users, :last_name, :text
  end
end
