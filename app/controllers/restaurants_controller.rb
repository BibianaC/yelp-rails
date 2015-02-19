class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @user = User.find(current_user)
    @restaurant = @user.restaurants.new(restaurants_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurants_params)

    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    p @restaurant
    p current_user
    if !current_user.restaurants.find_by id: @restaurant.id
      flash.notice ="Error: You must be the author to delete a review" 
    else 
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    end
    redirect_to '/restaurants'
  end

  private

  def restaurants_params
    params.require(:restaurant).permit(:name)
  end
  
end
