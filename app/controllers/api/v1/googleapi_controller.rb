class Api::V1::GoogleapiController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:place]
	skip_before_filter :authenticate_user!, :only => [:place]
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
		lat = params[:latitude]
		lng = params[:longitude]
		@response = Restaureant.find_by_sql("SELECT id, ( 3959 * acos( cos( radians("+lat+") ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians("+lng+") ) + sin( radians("+lat+") ) * sin( radians( latitude ) ) ) ) AS distance FROM restaurants HAVING distance < 25 ORDER BY distance LIMIT 0 , 20")
	end
end
