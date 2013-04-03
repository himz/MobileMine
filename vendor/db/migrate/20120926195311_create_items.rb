class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_url
      t.string :price
      t.string :availability
      t.text :description

      t.timestamps
    end
  end
end
