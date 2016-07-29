class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @visitor_latitude = request.location.latitude
    @visitor_longitude = request.location.longitude

    # @visitor_latitude = 46.8083268
    # @visitor_longitude = -100.7837392

    @restaurants = Restaurant.near([@visitor_latitude, @visitor_longitude], 50).order('created_at ASC')
    @fast_food_restaurants =    Restaurant.where(category_id: 1).near([@visitor_latitude, @visitor_longitude], 50)
    @fast_food_search = Category.find(1)
    @seafood_restaurants =      Restaurant.where(category_id: 2).near([@visitor_latitude, @visitor_longitude], 50)
    @seafood_search =   Category.find(2)
    @steak_house_restaurants =  Restaurant.where(category_id: 3).near([@visitor_latitude, @visitor_longitude], 50)
    @steak_house_search =   Category.find(3)
    @chinese_restaurants =      Restaurant.where(category_id: 4).near([@visitor_latitude, @visitor_longitude], 50)
    @chinese_search =   Category.find(4)
    @family_restaurants =       Restaurant.where(category_id: 5).near([@visitor_latitude, @visitor_longitude], 50)
    @family_search =   Category.find(5)
    @coffee_restaurants =       Restaurant.where(category_id: 6).near([@visitor_latitude, @visitor_longitude], 50)
    @coffee_search =   Category.find(6)
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
