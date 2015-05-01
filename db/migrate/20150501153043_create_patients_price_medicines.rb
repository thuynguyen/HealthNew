class CreatePatientsPriceMedicines < ActiveRecord::Migration
  def change
    create_table :patients_price_medicines do |t|
      t.integer :patient_id
      t.integer :price_medicine_id
      t.float :price
      t.integer :quantity
      t.timestamps
    end
  end
end
