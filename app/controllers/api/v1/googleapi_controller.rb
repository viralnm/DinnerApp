class Api::V1::GoogleapiController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:place, :newplace]
	skip_before_filter :authenticate_user!, :only => [:place, :newplace]
	def place
		# response = RestClient.post 'https://maps.googleapis.com/maps/api/place/textsearch/json', {:location => params[:location] , :radius => params[:radius], :type => params[:type], :key => params[:key]}
	 @key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
	 type = "food"
	 radius = 5000

	 @response=RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
                            timeout: 10, headers: {params: {key: @key, location: params[:location],:radius => radius, :type => type}})

	 @response = ActiveSupport::JSON.decode(@response)
	 # puts @response['results']
	end
	def newplace
		@key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
	 type = "cafe"
	 radius = 500
	 @array = Array.new
	 @response_google=RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
                            timeout: 10, headers: {params: {key: @key, location: params[:location],:radius => radius, :type => type}})
	@response_google = ActiveSupport::JSON.decode(@response_google)

    @response = Restaurant.near([params[:latitude], params[:longitude]], 500)
  
  #push google result in array 
  	if @response_google['results'].size > 0
  		@response_google['results'].each do |res|
  			photo = Array.new
  			if !res['photos'].blank?
  				res['photos'].each do |ph|
  					photo << {photo_url: "https://maps.googleapis.com/maps/api/place/photo?maxwidth="+ph['width'].to_s+"&photoreference="+ph['photo_reference']+"&key="+@key.to_s, photoreference: ph['photo_reference']}
  				end
  			else
  				photo << res['photos']
  			end
  			distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  			@array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
  		end
  	end
  # push local response in array
  	if  @response.size > 0
  		@response.each do |res|
  			photo = Array.new
  			db_photos = res.restaurant_photos.all
  			if !db_photos.blank?
  				db_photos.each do |ph|
  					photo << {photo_url: ph.photo.url, photoreference: ph.id}
  				end
  			else
  				photo << db_photos
  			end
  			@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res['rating'], distance: res.distance, photos: photo , add_manual: true}
  		end
  	end


  	@sorted = @array.sort_by { |k| k[:distance] }

	end
end
