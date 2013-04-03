class AddSecurityToCards < ActiveRecord::Migration
  def change
    remove_column :cards, :card_number
    add_column :cards, :card_number, :binary
    add_column :cards, :card_number_key, :binary
    add_column :cards, :card_number_iv, :binary
  end
end
