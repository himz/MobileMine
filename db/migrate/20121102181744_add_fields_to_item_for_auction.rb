class AddFieldsToItemForAuction < ActiveRecord::Migration
  def change
    add_column :items, :auction_flag, :boolean, :default=>false
    add_column :items, :auction_id, :integer
  end

end
