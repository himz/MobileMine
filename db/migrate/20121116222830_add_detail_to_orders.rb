class AddDetailToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :item_quantity, :integer
    add_column :orders, :shipping_address, :text
    add_column :orders, :billing_address, :text
    add_column :orders, :price, :float
    add_column :orders, :total_price, :float
    add_column :orders, :transaction_id, :integer
  end
end
