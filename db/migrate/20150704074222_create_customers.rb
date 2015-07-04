class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :hating_ingredient
      t.string :loving_taste

      t.timestamps null: false
    end
  end
end
