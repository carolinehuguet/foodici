class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :organic
      t.integer :price_cents
      t.integer :amount
      t.string :unit
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
