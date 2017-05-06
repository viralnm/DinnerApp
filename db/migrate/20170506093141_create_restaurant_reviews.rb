class CreateRestaurantReviews < ActiveRecord::Migration
  def change
    create_table :restaurant_reviews do |t|

      t.string    :name
      t.string    :text
      t.float     :rating
      t.string    :photo_file_name
      t.string    :photo_content_type
      t.string    :photo_file_size
      t.string    :photo_updated_at
      t.timestamps null: false
    end
  end
end
