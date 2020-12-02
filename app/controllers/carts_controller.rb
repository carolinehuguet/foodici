class CartsController < ApplicationController

	def show
    @cart = Order.find_or_create_by(
      user: current_user,
      status: "cart"
    )
    # itération sur la commande afin de les regrouper par catégories
		@order_lines = @cart.order_lines.order(:created_at).group_by { |order_line| order_line.shop.category }
		# nombre d'article dans la commande
		@article = @cart.order_lines.count
	end
end
