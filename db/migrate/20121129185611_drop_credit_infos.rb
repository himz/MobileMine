class DropCreditInfos < ActiveRecord::Migration
  def change
    drop_table :credit_infos
  end
end
