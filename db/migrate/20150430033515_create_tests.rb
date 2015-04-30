class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.text :description
      t.float :price
      t.float :origin_price

      t.timestamps
    end
  end
end
