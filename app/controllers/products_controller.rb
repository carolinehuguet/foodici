class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
    @order_line = OrderLine.new
    @cart = Order.find_or_create_by(
      status: "cart",
      user: current_user
      )
    @shops = Shop.all
    session[:original_fullpath] = request.original_fullpath

    if !params[:product].present? || params[:product] == "all"
      @products = Product.all
    end

    if params[:product] == "boucherie"
      @products = @products.joins(:shop).where(shops: {category: "Boucher"})
    end

    if params[:product] == "maraîcher"
      @products = @products.joins(:shop).where(shops: {category: "Fruits et légumes"})
    end

    if params[:product] == "vins et spiritueux"
      @products = @products.joins(:shop).where(shops: {category: "Caviste"})
    end

    if params[:product] == "epicerie fine"
      @products = @products.joins(:shop).where(shops: {category: "Epicerie fine"})
    end

    if params[:product] == "boulangerie"
      @products = @products.joins(:shop).where(shops: {category: "Boulanger"})
    end

    if params[:product] == "poissonnerie"
      @products = @products.joins(:shop).where(shops: {category: "Poissonier"})
    end

    if params[:product] == "crémerie"
      @products = @products.joins(:shop).where(shops: {category: "Fromager"})
    end

    if params[:product] == "produits régionaux"
      @products = @products.joins(:shop).where(shops: {category: "Crêpier"})
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
    @cart = current_user.orders.find_by(status: "cart")
    session[:original_fullpath] = request.original_fullpath
  end
end
