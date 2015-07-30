class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.binary :number
      t.string :expiration_month
      t.string :expiration_date
      t.binary :verification_code
      t.string :name

      t.timestamps null: false
    end
  end
end
