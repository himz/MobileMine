class ChangeAvailabilityToInteger < ActiveRecord::Migration
  def change
	remove_column :items, :availability
	add_column :items, :availability, :integer
  end
end
