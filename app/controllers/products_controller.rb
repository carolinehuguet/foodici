class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
    @order_line = OrderLine.new
    @shops = Shop.all
    session[:original_fullpath] = request.original_fullpath

    if !params[:product].present? || params[:product] == "all"
      @products = Product.all
    end

    if params[:product] == "boucherie"
      @products = @products.joins(:shop).where(shops: {category: "Boucher"})
    end

    if params[:bio] == "true"
      @products = @products.where(organic: true)
    end

    if params[:query].present?
      @products = @products.where("products.name ILIKE ?", "%#{params[:query]}%")
    end

  end

  def show
    @product = Product.find(params[:id])
    @order_line = OrderLine.new
    session[:original_fullpath] = request.original_fullpath
  end
end
