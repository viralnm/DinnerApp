class Api::V1::GoogleapiController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:place, :newplace]
	skip_before_filter :authenticate_user!, :only => [:place, :newplace]
	def place
		# response = RestClient.post 'https://maps.googleapis.com/maps/api/place/textsearch/json', {:location => params[:location] , :radius => params[:radius], :type => params[:type], :key => params[:key]}
	 @key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
	 type = "cafe"
	 radius = 5000

	 @response=RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
                            timeout: 10, headers: {params: {key: @key, location: params[:location],:radius => radius, :type => type}})

	 @response = ActiveSupport::JSON.decode(@response)
	 # puts @response['results']
	end
	def newplace
		@key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
	#  type = "cafe"
	#  radius = 500

	#  @response=RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
 #                            timeout: 10, headers: {params: {key: @key, location: params[:location],:radius => radius, :type => type}})
	# @response = ActiveSupport::JSON.decode(@response)

    @response = Restaurant.near([params[:latitude], params[:longitude]], 500)
  Geocoder::Calculations.distance_between([47.858205,2.294359], [40.748433,-73.985655])

	end
end
