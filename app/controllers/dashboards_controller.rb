class DashboardsController < ApplicationController
	def show
		@user = current_user
		@cart = @user.orders.find_by(status: "cart")
		@this_order_price = 0

		# map
		@shops = Shop.geocoded
		@markers = @shops.geocoded.map do |shop|
			{
				lat: shop.latitude,
				lng: shop.longitude
			}
		end
	end
end
