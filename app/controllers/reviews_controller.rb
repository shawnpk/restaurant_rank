class ReviewsController < ApplicationController
  before_action :set_restaurant
  before_action :authenticate_user!

  def index
  end

  def new
    @review = Review.new(restaurant: @restaurant)
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.restaurant = @restaurant

    if @review.save
      flash[:success] = "Awesome #{current_user.first_name}! Your review has been saved."
      redirect_to @restaurant
    else
      flash[:error] = "There was a problem creating your review #{current_user.first_name}. Please try again."
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:comment, :rating)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
