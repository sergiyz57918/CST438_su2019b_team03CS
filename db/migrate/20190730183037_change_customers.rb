class ChangeCustomers < ActiveRecord::Migration[5.2]
  def up
      change_column_default :customers, :lastOrder , from: nil,to: 0.0
      change_column_default :customers, :lastOrder2 , from: nil, to: 0.0
      change_column_default :customers, :lastOrder3 , from: nil, to: 0.0
      change_column_default :customers, :award , from: nil, to: 0.0
  end
end
