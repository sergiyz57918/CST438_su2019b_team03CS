class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :lastName, null: false
      t.string :firstName, null: false
      t.decimal :lastOrder , precision: 5, scale: 2
      t.decimal :lastOrder2 , precision: 5, scale: 2
      t.decimal :lastOrder3 , precision: 5, scale: 2
      t.decimal :award , precision: 5, scale: 2
      t.timestamps
    end
  end
end
