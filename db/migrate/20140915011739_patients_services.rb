class PatientsServices < ActiveRecord::Migration
  def change
  	create_table :patients_services, id: false do |t|
      t.integer :patient_id
      t.integer :service_id

      t.timestamps
    end
  end
end
