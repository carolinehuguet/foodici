class CreateOrderLines < ActiveRecord::Migration[6.0]
  def change
    create_table :order_lines do |t|
      t.integer :quantity
      t.integer :subtotal_price_cents
      t.references :product, null: false, foreign_key: true
      t.references :order_shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
