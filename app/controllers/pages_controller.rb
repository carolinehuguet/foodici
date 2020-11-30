class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:transportation] == "small_walk"
      @radius = 0.5
    elsif params[:transportation] == "bicycle"
      @radius = 5
    elsif params[:transportation] == "car"
      @radius = 10
    else
      @radius = 1
    end

    if params[:query].present?
      starting_data = Geocoder.search(params[:query]).first.data
      @starting_marker = {
          lat: starting_data["lat"],
          lng: starting_data["lon"]
        }

      @shops = Shop.near(params[:query], @radius)
    else
      @shops = Shop.all
    end

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @shops.geocoded.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: shop }),
        image_url: helpers.asset_url('picto/marker.svg')
      }
    end

  end

end
