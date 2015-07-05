class AddImageToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :image, :text
  end
end
