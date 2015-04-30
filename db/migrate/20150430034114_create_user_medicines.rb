class CreateUserMedicines < ActiveRecord::Migration
  def change
    create_table :user_medicines do |t|
      t.string :name
      t.float :quantity
      t.string :money
      t.text :description

      t.timestamps
    end
  end
end
