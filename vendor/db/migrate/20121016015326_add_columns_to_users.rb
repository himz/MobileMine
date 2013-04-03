class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :address, :text
    add_column :users, :zipcode, :integer
    add_column :users, :type, :integer

  end
end
