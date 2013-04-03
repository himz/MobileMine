class AddFieldsToItemForAuction < ActiveRecord::Migration
  def change
    add_column :items, :auction_flag, :boolean
    add_column :items, :auction_id, :integer
  end
end
