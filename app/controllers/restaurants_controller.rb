class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def create
    Restaurant.create(restaurants_params)
    redirect_to '/restaurants'
  end

  private

  def restaurants_params
    params.require(:restaurant).permit(:name)
  end
  
end
