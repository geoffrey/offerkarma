class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :username
      t.text :email, index: true

      t.timestamps
    end
    add_reference :users, :current_company, references: :companies, index: true


    add_reference :offers, :user, index: true
    add_reference :comments, :user, index: true
    add_reference :votes, :user, index: true
  end
end
