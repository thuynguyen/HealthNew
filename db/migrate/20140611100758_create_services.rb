class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.float :price
      t.references :patient

      t.timestamps
    end
  end
end
