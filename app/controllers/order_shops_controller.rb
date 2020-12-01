class OrderShopsController < ApplicationController
  def subtotal(order_shop)
    counter = 0
    subtotal = order_shop.orderlines.each do |i|
      counter + i.subtotal_price
      end
    return counter
  end

  def destroy
    @order_shop = OrderLine.find(params[:id]).order_shop
    @order_shop.destroy
  end
end
