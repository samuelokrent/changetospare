class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.float :amount
      t.string :status_cd, default: "new"
      t.integer :charity_id
      t.integer :card_id

      t.timestamps null: false
    end
    add_index :donations, :charity_id
    add_index :donations, :card_id
  end
end
