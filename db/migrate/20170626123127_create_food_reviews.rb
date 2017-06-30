class CreateFoodReviews < ActiveRecord::Migration
  def change
    create_table :food_reviews do |t|
      t.references :user
      t.references :food
      t.string :comments
      t.float :rating

      t.timestamps null: false
    end
  end
end
