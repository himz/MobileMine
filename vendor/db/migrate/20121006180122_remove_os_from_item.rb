class RemoveOsFromItem < ActiveRecord::Migration
  def up
    remove_column :items, :os
  end

  def down
    add_column :items, :os, :string
  end
end
