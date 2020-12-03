class DashboardsController < ApplicationController
	def show
		@user = current_user
		@cart = @user.orders.find_by(status: "cart")
		@this_order_price = 0


    @shops = []
    @cart_shops = @cart.order_shops.each do |order_shop|
      @shops << order_shop.shop
    end

    # map
		@markers = @shops.map do |shop|
			{
				lat: shop.latitude,
        lng: shop.longitude,
        image_url: helpers.asset_url('picto/marker.svg'),
        infoWindow: render_to_string(partial: "shared/dashboard/dashboard_info_window", locals: { shop: shop })
			}
    # @cart = current_user.orders.find(params[:id])
    end
  end
end
