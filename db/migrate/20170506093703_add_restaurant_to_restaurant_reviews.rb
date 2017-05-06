class AddRestaurantToRestaurantReviews < ActiveRecord::Migration
  def change
  	add_reference :restaurant_reviews, :restaurant, index: true, foreign_key: true
  end
end
