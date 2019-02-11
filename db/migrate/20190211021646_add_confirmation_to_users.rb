class AddConfirmationToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :email
    add_index :users, :email, unique: true

    add_column :users, :confirmation_digest, :string, unique: true
    add_column :users, :confirmed_at, :datetime
  end
end
