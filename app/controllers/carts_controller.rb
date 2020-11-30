class CartsController < ApplicationController

	def show
		@cart = current_user.orders.find_by(status: "cart")
		# itération sur la commande afin de les regrouper par catégories
		@order_lines = @cart.order_lines.order(:created_at).group_by { |order_line| order_line.shop.category }
		# nombre d'article dans la commande
		@article = @cart.order_lines.count
		# récupération de la quantité
		# @quantity = 
	end
end
