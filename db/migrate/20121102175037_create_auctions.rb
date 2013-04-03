class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :item_id
      t.integer :seller_id
      t.float :bid_amount
      t.integer :highest_bidder
      t.integer :state

      t.timestamps
    end
  end
end
