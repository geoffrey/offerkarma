class ChangeOffersColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :scope
    remove_column :offers, :status

    add_column :offers, :scope, :integer
    add_column :offers, :status, :integer
  end
end
