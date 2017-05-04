class Restaurant < ActiveRecord::Base
	

	has_attached_file :photo, :styles => {:avatar => "100x100#"}
	validates_presence_of :name, :message => "Name can't be blank"
	validates_presence_of :formatted_address, :message => "Address can't be blank"
	validates_presence_of :latitude, :message => "Latitude can't be blank"
	validates_presence_of :longitude, :message => "Longitude can't be blank"
	validates_presence_of :photo, :message => "Longitude can't be blank"

	 geocoded_by :formatted_address, :skip_index => true
	 after_validation :geocode 
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
	        help 'Enter rating'
	      end
	      field :photo do
	        help 'upload Photo'
	      end	     
	      field :add_manual do
	        help ' '
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
	        help 'Enter rating'
	      end
	      field :photo do
	        help 'upload Photo'
	      end	     
	      field :add_manual do
	        help ' '
	      end
		end
	end
end
