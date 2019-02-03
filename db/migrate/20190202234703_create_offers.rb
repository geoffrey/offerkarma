class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :company, foreign_key: true
      t.boolean :public
      t.boolean :comments_enabled
      t.boolean :votes_enabled
      t.integer :base_salary
      t.integer :signon_bonus
      t.integer :relocation_package
      t.text :notes
      t.integer :bonus_per_year_amount
      t.integer :bonus_per_year_percent
      t.boolean :accepted

      t.timestamps
    end
  end
end
