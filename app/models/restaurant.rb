class Restaurant < ActiveRecord::Base
	has_many :restaurant_photos, dependent: :destroy
	has_many :restaurant_reviews, dependent: :destroy
	has_many :foods, dependent: :destroy
	validates_presence_of :name, :message => "Name can't be blank"
	validates_presence_of :formatted_address, :message => "Address can't be blank"

	 geocoded_by :formatted_address, :skip_index => true
	 after_validation :geocode 
	 # after_save :add_latitude_longitude 


	 # def add_latitude_longitude
	 # 		coordinates = Geocoder.coordinates(self.formatted_address)
	 # 		if !coordinates.blank?
		#  		# self.latitude = coordinates[0]
		#  		# self.longitude = coordinates[1]
		#  		# self.save
		#  		puts self.changed[1]
		#  		# self.update_attributes(:latitude => coordinates[0], :longitude => coordinates[1])

		#  	end
	 	
	 # end
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
	       field :rating do
	        help 'Enter rating'
	      end     
	      field :add_manual do
	        help ' '
	      end
	      field :photo do
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
	       field :rating do
	        help 'Enter rating'
	      end     
	      field :add_manual do
	        help ' '
	      end
		end
	end
end
