class RestaurantsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @restaurants = Restaurant.all
    @value = Review.group(:restaurant).average(:rating)
  end
  
  def new
    @restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      redirect_to restaurants_path
    else
      flash.keep[:notice] = "Restaurant already exists"
      redirect_to new_restaurant_path
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :image)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to restaurants_path
  end
end
