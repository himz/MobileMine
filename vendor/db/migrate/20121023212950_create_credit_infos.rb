class CreateCreditInfos < ActiveRecord::Migration
  def change
    create_table :credit_infos do |t|
      t.integer :user_id
      t.string :billing_address
      t.string :credit_card_no
      t.integer :zipcode

      t.timestamps
    end
  end
end
