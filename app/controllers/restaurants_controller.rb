class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.order('created_at DESC')
  end
  def show
    @restaurant = Restaurant.find(params[:id])
  end
  def new
    @restaurant = Restaurant.new
  end
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "#{@restaurant.name} has been created successfully."
      redirect_to @restaurant
    else
      flash[:error] = "Restaurant was not created. Please try again."
      render :new
    end
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :address1, :address2, :city, :state_provence, :postalcode, :phone, :website, :category_id)
    end
end
