class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
          has_attached_file :photo, :styles => {:avatar => "100x100#"}
 	rails_admin do
 		list do
 			field :first_name
 			field :last_name
 			field :email
 			field :facebook_id
 			field :google_id
 		end
	    create do
	      field :first_name do
	        help 'Enter First Name'
	      end
	      field :last_name do
	        help 'Enter First Name'
	      end
	      field :email do
	        help 'Enter Email Address'
	      end
	      field :password do
	        help 'Enter Password'
	      end
	      field :password_confirmation do
	        help 'Re-enter Password'
	      end
	      field :photo do
	        help 'upload Photo'
	      end
	      field :facebook_id do
	        help 'Enter facebook Id'
	      end
	      field :google_id do
	        help 'Enter google Id'
	      end
	      field :photo_url do
	        help 'Enter photo URL'
	      end
	     
	      field :devise_token do
	        help 'Enter Devise Token'
	      end
	    end

	    edit do
	      field :first_name do
	        help 'Enter First Name'
	      end
	      field :last_name do
	        help 'Enter First Name'
	      end
	      field :email do
	        help 'Enter Email Address'
	      end
	      field :password do
	        help 'Enter Password'
	      end
	      field :password_confirmation do
	        help 'Re-enter Password'
	      end
	      field :photo do
	        help 'upload Photo'
	      end
	      field :facebook_id do
	        help 'Enter facebook Id'
	      end
	      field :google_id do
	        help 'Enter google Id'
	      end
	      field :photo_url do
	        help 'Enter photo URL'
	      end
	      field :devise_token do
	        help 'Enter Devise Token'
	      end
		end
	end
end
