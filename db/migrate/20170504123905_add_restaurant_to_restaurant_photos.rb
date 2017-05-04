class AddRestaurantToRestaurantPhotos < ActiveRecord::Migration
  def change
    add_reference :restaurant_photos, :restaurant, index: true, foreign_key: true
  end
end
