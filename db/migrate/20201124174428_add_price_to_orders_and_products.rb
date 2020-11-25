class AddPriceToOrdersAndProducts < ActiveRecord::Migration[6.0]
  def change
    add_monetize :products, :price, currency: { present: false }
    add_monetize :orders, :total_price, currency: { present: false }
    add_monetize :order_lines, :subtotal_price, currency: { present: false }
    add_monetize :order_shops, :subtotal_price, currency: { present: false }
  end
end
