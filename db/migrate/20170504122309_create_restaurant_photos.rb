class CreateRestaurantPhotos < ActiveRecord::Migration
  def change
    create_table :restaurant_photos do |t|

      t.timestamps null: false
      t.string    :photo_file_name
      t.string    :photo_content_type
      t.string    :photo_file_size
      t.string    :photo_updated_at
    end
  end
end
