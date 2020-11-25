class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all

    if params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def show
    # @products = Product.find(params[:id])
  end
end
