class CreateOrderShops < ActiveRecord::Migration[6.0]
  def change
    create_table :order_shops do |t|
      t.string :status
      t.integer :subtotal_price_cents
      t.references :order, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
