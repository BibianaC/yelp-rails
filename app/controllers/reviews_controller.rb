class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if !current_user
      redirect_to '/users/sign_in'
    elsif current_user.has_reviewed?(@restaurant)
      flash[:notice] = 'You have already reviewed this restaurant'
      redirect_to restaurants_path
    else
      @review = Review.new
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)
    redirect_to restaurants_path
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user.id != @review.user_id
      flash[:notice] = 'Error: You must be the author to delete a review'
    else
      @review.destroy
      flash[:notice] = "Review deleted successfully"
    end
    redirect_to restaurants_path
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating, :user_id)
  end

end
