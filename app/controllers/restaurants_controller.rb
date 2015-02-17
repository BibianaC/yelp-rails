class RestaurantsController < ApplicationController
  def index
    @restaurant = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurants_params)
    redirect_to '/restaurants'
  end

  private

  def restaurants_params
    params.require(:restaurant).permit(:name)
  end
  
end
