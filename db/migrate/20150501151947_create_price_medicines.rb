class CreatePriceMedicines < ActiveRecord::Migration
  def change
    create_table :price_medicines do |t|
      t.string :name
      t.integer :unit
      t.string :price

      t.timestamps
    end
  end
end
