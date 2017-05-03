class StaticpageController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:terms_condition, :privacy_policy, :QF]
	def terms_condition
		render :layout => false  
	end
	def privacy_policy
		render :layout => false
	end
	def QF
		render :layout => false
	end
end
	