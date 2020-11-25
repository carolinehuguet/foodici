class RemovePriceCents < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :price_cents, :integer
    remove_column :orders, :total_price_cents, :integer
    remove_column :order_shops, :subtotal_price_cents, :integer
    remove_column :order_lines, :subtotal_price_cents, :integer
  end
end
