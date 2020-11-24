class ShopsController < ApplicationController

  def show
    @shops = Shop.find(params[:id])
  end
end
