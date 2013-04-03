class AddJobIdToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :job_id, :integer
  end
end
