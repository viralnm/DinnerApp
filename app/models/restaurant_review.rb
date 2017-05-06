class RestaurantReview < ActiveRecord::Base
	belongs_to :restaurant
	has_attached_file :photo, :styles => {:avatar => "100x100#"}
	rails_admin do
 		list do
 			field :photo
 			field :name
 			field :text
 			field :rating
 			field :restaurant
 		end
 	end
end
