class RestaurantsController < ApplicationController
  include WithUserAssociationExtension
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
    @reviews = Review.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  # def updated
  #   @restaurant = Restuarant.find(params[:id])
  #   @restaurant.update(restaurant_params)
  #   redirect_to '/restaurants'
  # end

  def destroy
   @restaurant = Restaurant.find(params[:id])
   @restaurant.destroy
   flash[:notice] = 'Restaurant deleted successfully'
   redirect_to '/restaurants'
  end

end
