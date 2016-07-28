class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = Review.where(restaurant_id: @restaurant)
    if @reviews.blank?
      @average_rating = 0
    else
      @average_rating = @reviews.average(:rating).round(2)
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @user = current_user
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "Awesome #{@user.username}! #{@restaurant.name} has been created successfully."
      redirect_to @restaurant
    else
      flash[:error] = "Sorry #{@user.username}, your restaurant was not created. Please see the error messages below."
      render :new
    end
  end

  def search
    @restaurants = Restaurant.search(params)
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :address1, :address2, :city, :state_provence, :postalcode, :phone, :website, :category_id, :image)
    end
end
