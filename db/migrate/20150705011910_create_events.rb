class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :host_email
      t.text :name
      t.text :accept_email
      t.text :decline_email
      t.text :pending_email
      t.text :address
      t.datetime :occur_date

      t.timestamps null: false
    end
  end
end
