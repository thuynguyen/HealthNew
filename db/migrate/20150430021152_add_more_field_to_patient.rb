class AddMoreFieldToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :phone, :string
    add_column :patients, :order, :integer
  end
end
