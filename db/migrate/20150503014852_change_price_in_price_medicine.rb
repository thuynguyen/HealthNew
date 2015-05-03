class ChangePriceInPriceMedicine < ActiveRecord::Migration
  def change
    remove_column :price_medicines, :price
    add_column :price_medicines, :price, :float
  end
end
