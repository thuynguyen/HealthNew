class RemovePatientsService < ActiveRecord::Migration
  def change
  	drop_table :patients_services
  	create_table :patients_services do |t|
      t.integer :patient_id
      t.integer :service_id
      t.float :price

      t.timestamps
    end
  end
end
