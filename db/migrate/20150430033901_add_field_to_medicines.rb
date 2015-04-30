class AddFieldToMedicines < ActiveRecord::Migration
  def change
    add_column :medicines, :quantity, :float
    add_column :medicines, :money, :float
  end
end
