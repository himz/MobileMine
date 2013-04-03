class ChangeAvailabilityToInteger < ActiveRecord::Migration
  def change
    change_column :items, :availability, :integer
  end
end
