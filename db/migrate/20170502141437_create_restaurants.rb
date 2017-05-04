class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string    :name
      t.string    :formatted_address
      t.float    :latitude
      t.float    :longitude
      t.float   :rating
      t.boolean   :add_manual, default: true

      t.timestamps null: false
    end
  end
end
