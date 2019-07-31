class CreateCustomers < ActiveRecord::Migration[5.2]
  def up
    change_table :customers, :bulk => true do |t|
      t.string :email, null: false
      t.string :lastName, null: false
      t.string :firstName, null: false
      t.decimal :lastOrder , precision: 5, scale: 2, default: 0.0
      t.decimal :lastOrder2 , precision: 5, scale: 2, default: 0.0
      t.decimal :lastOrder3 , precision: 5, scale: 2, default: 0.0
      t.decimal :award , precision: 5, scale: 2, default: 0.0
      t.timestamps
    end
  end
end
