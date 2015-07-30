class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.text :about
      t.string :website

      t.timestamps null: false
    end
  end
end
