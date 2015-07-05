class AddFieldnameIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image, :text
  end
