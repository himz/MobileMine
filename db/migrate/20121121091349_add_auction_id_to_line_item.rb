class AddAuctionIdToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :auction_id, :integer
  end
end
