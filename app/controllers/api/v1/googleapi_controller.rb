class Api::V1::GoogleapiController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:place, :newplace, :place_details,:placewithfilter]
	skip_before_filter :authenticate_user!, :only => [:place, :newplace, :place_details,:placewithfilter ]
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
  				distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  				@array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
  			else
  				distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  				@array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
  			end
  			
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
  				@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  			else
  				@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  			end
  			
  		end
  	end


  	@sorted = @array.sort_by { |k| k[:distance] }

	end

	def placewithfilter
		@key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
	  type = "cafe"
	  radius = 200
	  @array = Array.new
	  @response_google=RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
                            timeout: 20, headers: {params: {key: @key, location: params[:location],:radius => radius, :type => type}})
	  @response_google = ActiveSupport::JSON.decode(@response_google)

    @response = Restaurant.near([params[:latitude], params[:longitude]], 500)
  
  #push google result in array 
  	if @response_google['results'].size > 0
  		@response_google['results'].each do |res|
  			photo = Array.new
  			if !res['photos'].blank?
  				res['photos'].each do |ph|
  					url_c = "https://maps.googleapis.com/maps/api/place/photo?maxwidth="+ph['width'].to_s+"&photoreference="+ph['photo_reference']+"&key="+@key.to_s
      			@s_urls = RestClient.post "https://www.googleapis.com/urlshortener/v1/url/?key=AIzaSyBU_beRXw4pisGLzJLlwMAdKaBhj3XTYCY", {"longUrl" => url_c}.to_json, :content_type => "application/json"
  					@s_urls = ActiveSupport::JSON.decode(@s_urls)
  					image_url = @s_urls['id']
						api_key = 'acc_61d09fb31788cb1'
						api_secret = 'e818bc86ebe0f859b8d3a56233578ce0'
						auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
					 	@img_check = RestClient.get "https://api.imagga.com/v1/tagging?url=#{image_url}", { :Authorization => auth }
					 	@img_check= ActiveSupport::JSON.decode(@img_check)
					 	puts @img_check
						@img_check['results'].each do |r|
							r['tags'].each do |t|
								if t['tag'] == "food"
									puts t['tag']
									photo << {photo_url: "https://maps.googleapis.com/maps/api/place/photo?maxwidth="+ph['width'].to_s+"&photoreference="+ph['photo_reference']+"&key="+@key.to_s, photoreference: ph['photo_reference']}
								end
							end
						end
  				end

  				distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  				@array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
  			else
  				distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  				@array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
  			end
  			
  		end
  	end
  # push local response in array
  	if  @response.size > 0
  		@response.each do |res|
  			photo = Array.new
  			db_photos = res.restaurant_photos.all
  			if !db_photos.blank?
  				db_photos.each do |ph|
  					# url_c = ph.photo.url
      	# 		@s_urls = RestClient.post "https://www.googleapis.com/urlshortener/v1/url/?key=AIzaSyBU_beRXw4pisGLzJLlwMAdKaBhj3XTYCY", {"longUrl" => url_c}.to_json, :content_type => "application/json"
  					# @s_urls = ActiveSupport::JSON.decode(@s_urls)
  					image_url = "http://54.218.251.105:3000"+ph.photo.url
						api_key = 'acc_61d09fb31788cb1'
						api_secret = 'e818bc86ebe0f859b8d3a56233578ce0'
						auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
					 	@img_check = RestClient.get "https://api.imagga.com/v1/tagging?url=#{image_url}", { :Authorization => auth }
					 	@img_check= ActiveSupport::JSON.decode(@img_check)
					 	puts @img_check
						@img_check['results'].each do |r|
							r['tags'].each do |t|
								if t['tag'] == "food"
									puts t['tag']
									photo << {photo_url: ph.photo.url, photoreference: ph.id}
								end
							end
						end
  				end

  				@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  			else
  				@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  			end
  			
  		end
  	end


  	@sorted = @array.sort_by { |k| k[:distance] }
		 
	end

	def place_details
		@add_manual = params[:add_manual]
		if @add_manual == 'true'
			@res = Restaurant.find(params[:placeid])
			@res_reviews = @res.restaurant_reviews.all 
			@db_photos = @res.restaurant_photos.all
		else
			@key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
			@res = RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/details/json',
	                            timeout: 10, headers: {params: {placeid: params[:placeid], key: @key}})
			@res = ActiveSupport::JSON.decode(@res)
		end
	end

end
