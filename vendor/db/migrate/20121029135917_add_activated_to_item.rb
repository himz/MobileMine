class AddActivatedToItem < ActiveRecord::Migration
  def change

    add_column :items, :activated, :boolean, :default=>true

  end
end
