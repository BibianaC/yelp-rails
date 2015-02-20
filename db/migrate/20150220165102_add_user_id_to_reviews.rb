class AddUserIdToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :user, index: true
    add_foreign_key :reviews, :users
  end
end
