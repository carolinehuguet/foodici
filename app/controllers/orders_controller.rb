class OrdersController < ApplicationController
  def create
    order = current_user.orders.find_by(status: "cart")
    order_total = 0

    order.order_shops.each do |order_shop|
      order_shop.order_lines.each do |order_line|
        order_total += order_line.subtotal_price_cents
        end
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      locale: "fr",
      line_items: [{
        amount: order_total,
        currency: 'eur',
        quantity: 1,
        name: "Food'ici"
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
