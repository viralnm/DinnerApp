class Api::V1::FoodsController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:create]
	skip_before_filter :authenticate_user!, :only => [:create ]
	def create
		@food = Food.create(food_params)
		if @food.save
			respond_to do |format|			
				format.json { render :json => {action: 'food_add',
		              response: 'true',
		             msg: 'food was added sucessfully.'} }
			end
		else
			respond_to do |format|			
				format.json { render :json => {action: 'food_add',
		              response: 'flase',
		             msg: 'food was not added.'} }
			end
		end
	end

  private
    def food_params 
      params.require(:food).permit(:name,:user_id, :restaurant_id, :photo_file_name)
    end
end
