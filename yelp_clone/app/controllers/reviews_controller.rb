class ReviewsController < ApplicationController
  include WithUserAssociationExtension
  before_action :authenticate_user!, :except => [:index, :show]


  def new

    if current_user.has_reviewed? @restaurant
      flash[:notice] = 'You have already reviewed this restaurant'
    end

    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        # Note: if you have correctly disabled the review button where appropriate,
        # this should never happen...
        # redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
        flash[:notice] = 'You have already reviewed this restaurant'
        redirect_to '/'
      else
        # Why would we render new again?  What else could cause an error?
        render :new
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      flash[:notice] = 'The review has been deleted'
    else
      flash[:notice] = 'The review can only be deleted by its creator'
    end
    redirect_to '/restaurants'
  end


  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
