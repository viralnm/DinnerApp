class Api::V1::RestaurantReviewController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:create]
	skip_before_filter :authenticate_user!, :only => [:create ]
	def create
	
	end

  private
    def review_params 
      params.require(:user).permit(:name,:text, :rating, :email, :restaurant_id, :photo_file_name)
    end
end
