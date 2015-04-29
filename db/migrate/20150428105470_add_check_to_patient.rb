class AddCheckToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :is_paid, :boolean, default: false
    add_column :patients, :description, :text
  end
end
