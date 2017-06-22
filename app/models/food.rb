class Food < ActiveRecord::Base
	has_attached_file :photo, :styles => {:avatar => "100x100#"}
	belongs_to :restaurant
	belongs_to :user
	rails_admin do
 		list do
 			field :name
 			field :restaurant
 			field :user do 
 				pretty_value do
            value.try(:email)
        end
 			end
 			field :photo
 		end
    create do
      field :restaurant do
        help 'select Restaurant '
      end
      field :user, :enum do
        enum do
          User.all.pluck(:email, :id)
      	end
      end
      field :name do
        help 'enter name'
      end
      field :photo do
        help 'upload Photo'
      end 
    end

    edit do
      field :restaurant do
        help 'select Restaurant '
      end
      field :user_id, :enum do
        enum do
          User.all.pluck(:email, :id)
      	end
      end
      field :name do
        help 'enter name'
      end
      field :photo do
        help 'upload Photo'
      end
		end
	end
end
