class DashboardsController < ApplicationController
	def show
		@user = current_user

    @cart = @user.orders.where(status: "pending").last
    @cart = @users.orders.create_or_find_by(status: "cart") if !@cart.present?
		@this_order_price = 0

    @order_shops = @cart.order_shops

    # map
		@markers = @order_shops.map do |order_shop|
			{
        lat: order_shop.shop.latitude,
        lng: order_shop.shop.longitude,
        image_url: helpers.asset_url( order_shop.status == "completed" ? 'picto/marker-approved.svg' : 'picto/marker-pending.svg'),
        infoWindow: render_to_string(partial: "shared/dashboard/dashboard_info_window", locals: { shop: order_shop.shop })
      }
    end
  end
end
