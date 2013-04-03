class AddTypeToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :line_item_type, :integer
  end
end
