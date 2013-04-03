class AddAuctionsToUser < ActiveRecord::Migration
  def change

    add_column :users, :auctions, :text

  end
end
