class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string    :name
      t.string    :formatted_address
      t.string    :latitude
      t.string    :longitude
      t.integer   :rating
      t.string    :photo_file_name
      t.string    :photo_content_type
      t.string    :photo_file_size
      t.string    :photo_updated_at
      t.boolean   :add_manual, default: true

      t.timestamps null: false
    end
  end
end
