class RestaurantPhoto < ActiveRecord::Base
	belongs_to :restaurant
	has_attached_file :photo, :styles => {:avatar => "100x100#"}
	rails_admin do
 		list do
 			field :restaurant
 			field :photo
 		end
	    create do
	      field :restaurant do
	        help 'select Restaurant '
	      end
	      field :photo do
	        help 'upload Photo'
	      end
	    end

	    edit do
	      field :restaurant do
	        help 'select Restaurant '
	      end
	      field :photo do
	        help 'upload Photo'
	      end
		end
	end
end
