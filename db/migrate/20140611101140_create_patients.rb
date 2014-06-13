class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.integer :year
      t.string :address
      t.references :user

      t.timestamps
    end
  end
end
