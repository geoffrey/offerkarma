class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.text :first_name
      t.text :last_name
      t.text :username
      t.text :email, index: true

      t.timestamps
    end
    add_reference :users, :current_company, references: :companies, type: :uuid, index: true
    add_reference :offers, :user, type: :uuid, index: true
    add_reference :comments, :user, type: :uuid, index: true
    add_reference :votes, :user, type: :uuid, index: true
  end
end
