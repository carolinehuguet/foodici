class OrderLinesController < ApplicationController
  def create
    @cart = Order.find_or_create_by(
      user: current_user,
      status: "cart"
    )
    @product = Product.find(params[:product_id])
    @shop = @product.shop
    @order_shop = OrderShop.find_or_create_by(
      order: @cart,
      shop: @shop
    )
    @order_line = OrderLine.new(order_line_params)
    @order_line.product = @product
    @order_line.order_shop = @order_shop
    @order_line.subtotal_price = @product.price * @order_line.quantity

    if @order_line.save!
      redirect_to @product
    else
      render(
        html: "<script>alert('Désolé, ce produit n'est plus disponible.')</script>".html_safe,
        layout: 'application'
      )
    end
  end

  def index
    @order_lines = OrderLine.all
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to cart_path
  end


  private
  def order_line_params
    params.require(:order_line).permit(:quantity)
  end
end
