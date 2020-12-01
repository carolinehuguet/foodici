class ShopsController < ApplicationController

  def show
    @shops = Shop.find(params[:id])
  end

  def index

    if params[:transportation] == "small_walk"
      @radius = 0.5
    elsif params[:transportation] == "bicycle"
      @radius = 3
    elsif params[:transportation] == "car"
      @radius = 10
    else
      @radius = 1
    end

    if params[:address].present?
      starting_data = Geocoder.search(params[:address]).first.data
      @starting_marker = {
          lat: starting_data["lat"],
          lng: starting_data["lon"]
        }
      @shops = Shop.near(params[:address], @radius)
    else
      @shops = Shop.all
    end

    # filters shops with coordinates (latitude & longitude)
    @markers = @shops.geocoded.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: render_to_string(partial: "info_window", formats: :html, layout: false, locals: { shop: shop }),
        image_url: helpers.asset_url('picto/marker.svg')
      }
    end

    render json: { markers: @markers, starting_marker: @starting_marker }
  end
end
