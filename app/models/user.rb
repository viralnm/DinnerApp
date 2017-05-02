class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
 	rails_admin do
	    create do
	      field :first_name do
	        help 'Enter First Name'
	      end
	      field :last_name do
	        help 'Enter First Name'
	      end
	      field :email do
	        help 'Email Email Address'
	      end
	      field :password do
	        help 'Enter Password'
	      end
	      field :password_confirmation do
	        help 'Re-enter Password'
	      end
	      field :devise_token do
	      	help 'enter Devise_token'
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
		end
	end


end
