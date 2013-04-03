class ChangeColumnsToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :type
    add_column :users, :user_type, :integer

  end
end
