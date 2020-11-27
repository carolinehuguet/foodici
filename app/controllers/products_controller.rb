class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
    @order_line = OrderLine.new
    session[:original_fullpath] = request.original_fullpath

    if params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
    @order_line = OrderLine.new
    session[:original_fullpath] = request.original_fullpath
  end
end
