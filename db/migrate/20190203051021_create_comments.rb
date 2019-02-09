class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :offer, type: :uuid, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
