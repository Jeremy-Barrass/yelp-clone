class ReviewsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review review_params, current_user

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        flash[:notice] = 'You have already reviewed this restaurant'
        redirect_to restaurants_path
      else
        render :new
      end
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "review successfully deleted"
    redirect_to restaurants_path
  end

end
