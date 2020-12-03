class DashboardsController < ApplicationController
	def show
		@user = current_user

    status = Rails.env.development? ? "cart" : "pending"
		@cart = @user.orders.find_by(status: status)
		@this_order_price = 0

        @shops = @cart.shops

    # map
		@markers = @shops.map do |shop|
			{
				lat: shop.latitude,
        lng: shop.longitude,
        image_url: helpers.asset_url('picto/marker.svg'),
        infoWindow: render_to_string(partial: "shared/dashboard/dashboard_info_window", locals: { shop: shop })
			}
    end
  end
end
