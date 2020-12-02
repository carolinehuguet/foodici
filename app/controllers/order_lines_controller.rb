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
    @order_line = OrderLine.find_or_create_by(
      order_shop: @order_shop,
      product: @product
    )
    @order_line.quantity = order_line_params[:quantity]
    @order_line.subtotal_price = @product.price * @order_line.quantity

    if @order_line.save!

      respond_to do |format|
        format.html { redirect_to session[:original_fullpath] }
        format.json { render json: { order_line_id: @order_line.id, cartlist: render_to_string(partial: "products/cartlist", formats: :html, layout: false) } }
      end

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
    @order_line = OrderLine.find(params[:id])
    if @order_line.order_shop.order_lines.count == 1
      @order_line.destroy
      @order_line.order_shop.destroy
    else
      @order_line.destroy
    end
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.json { render json: { cartlist: render_to_string(partial: "products/cartlist", formats: :html, layout: false) } }
    end
  end

  def decrease_quantity
    @order_line = OrderLine.find(params[:id])
    if @order_line.quantity > 0
      @order_line.quantity -= 1
    end
    @order_line.save
    redirect_to cart_path
  end

  def increase_quantity
    @order_line = OrderLine.find(params[:id])
    @order_line.quantity += 1
    @order_line.save
    redirect_to cart_path
  end



  private
  def order_line_params
    params.require(:order_line).permit(:quantity)
  end
end
