class Restaurant < ActiveRecord::Base
	has_attached_file :photo, :styles => {:avatar => "100x100#"}
	rails_admin do
 		list do
 			field :name
 			field :latitude
 			field :longitude
 			field :rating
 			field :formatted_address
 		end
	    create do
	      field :name do
	        help 'Enter Name'
	      end
	      field :formatted_address do
	        help 'Enter formatted address'
	      end
	      field :latitude do
	        help 'Enter latitude'
	      end
	      field :longitude do
	        help 'Enter longitude'
	      end
	       field :rating do
	        help 'Enter facebook Id'
	      end
	      field :photo do
	        help 'upload Photo'
	      end	     
	      field :add_manual do
	        help 'Enter google Id'
	      end
	    end

	    edit do
	      field :name do
	        help 'Enter Name'
	      end
	      field :formatted_address do
	        help 'Enter formatted address'
	      end
	      field :latitude do
	        help 'Enter latitude'
	      end
	      field :longitude do
	        help 'Enter longitude'
	      end
	       field :rating do
	        help 'Enter facebook Id'
	      end
	      field :photo do
	        help 'upload Photo'
	      end	     
	      field :add_manual do
	        help 'Enter google Id'
	      end
		end
	end
end
