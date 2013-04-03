class AddFieldsToItem < ActiveRecord::Migration
  def change
    add_column :items, :manufacturer, :string
    add_column :items, :sold_count, :integer,:default =>0
    add_column :items, :featured, :boolean, :default=>false
    add_column :items, :os, :string
    add_column :items, :category_id, :integer
  end
end
