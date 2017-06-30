class Api::V1::FoodReviewsController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:create]
	skip_before_filter :authenticate_user!, :only => [:create ]
	def create
		@food = FoodReview.create(food_review_params)
		if @food.save
			respond_to do |format|			
				format.json { render :json => {action: 'food_review_add',
		              response: 'true',
		             msg: 'food Review was added sucessfully.',
		             id: @food.id} }
			end
		else
			respond_to do |format|			
				format.json { render :json => {action: 'food_review_add',
		              response: 'flase',
		             msg: 'food Review was not added.'} }
			end
		end
	end

  private
    def food_review_params 
      params.require(:food_review).permit(:comments,:user_id, :food_id, :rating)
    end
end
