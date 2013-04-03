class RemoveCategoryIdFromItem < ActiveRecord::Migration
  def up
    remove_column :items, :category_id
  end

  def down
    add_column :items, :category_id, :integer
  end
end
