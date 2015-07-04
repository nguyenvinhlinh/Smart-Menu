class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.string :category
      t.string :ingredient
      t.string :taste

      t.timestamps null: false
    end
  end
end
