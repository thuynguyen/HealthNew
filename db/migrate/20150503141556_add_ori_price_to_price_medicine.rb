class AddOriPriceToPriceMedicine < ActiveRecord::Migration
  def change
    add_column :price_medicines, :e, :string
    add_column :price_medicines, :origin_price, :float
  end
end
