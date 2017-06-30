class RestaurantPhoto < ActiveRecord::Base
	belongs_to :restaurant
	has_attached_file :photo, :styles => {:avatar => "100x100#"}
	# mount :photo, ImageUploader
	# :path => ":rails_root/public/system/img/:id/:style/:basename.jpg",
	# :url => "/system/img/:id/:style/:basename.jpg"
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
