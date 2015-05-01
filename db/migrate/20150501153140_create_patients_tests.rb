class CreatePatientsTests < ActiveRecord::Migration
  def change
    create_table :patients_tests do |t|
      t.integer :patient_id
      t.integer :test_id
      t.float :price

      t.timestamps
    end
  end
end
