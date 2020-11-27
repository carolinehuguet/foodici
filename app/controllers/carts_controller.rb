class CartsController < ApplicationController

	def show
		@cart = current_user.orders.find_by(status: "cart")
		@order_lines = @cart.order_lines.group_by { |order_line| order_line.shop.category }
	end
end
