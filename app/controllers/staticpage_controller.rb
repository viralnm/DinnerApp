class StaticpageController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:terms_condition, :privacy_policy, :QF]
	def privacy_policy
		@data = StaticPage.find(1) 
		render :layout => false
	end
	def terms_condition
		@data = StaticPage.find(2) 
		render :layout => false
	end
	
	def QF
		@data = StaticPage.find(3) 
		render :layout => false
	end
end
	