class AddPriceToPatientsService < ActiveRecord::Migration
  def change
    add_column :patients_services, :price, :float
  end
end
