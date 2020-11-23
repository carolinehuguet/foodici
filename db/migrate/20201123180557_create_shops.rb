class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :opening_hour
      t.string :closing_hour
      t.integer :opening_days, array: true, default: []
      t.string :phone_number
      t.string :category
      t.text :description
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
