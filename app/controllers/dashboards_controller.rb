class DashboardsController < ApplicationController
	def show
		@user = current_user
		@cart = @user.orders.find_by(status: "cart")
		@this_order_price = 0
	end
end
