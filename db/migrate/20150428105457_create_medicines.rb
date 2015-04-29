class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.string :name
      t.text :description
      t.datetime :expired_date

      t.timestamps
    end
  end
end
