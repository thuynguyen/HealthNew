class CreateUserTests < ActiveRecord::Migration
  def change
    create_table :user_tests do |t|
      t.integer :test_id
      t.text :description

      t.timestamps
    end
  end
end
