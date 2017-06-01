class Api::V1::GoogleapiController < Api::BaseController
	skip_before_action :verify_authenticity_token, :only => [:place, :newplace, :place_details,:placewithfilter,:place_old, :review]
	skip_before_filter :authenticate_user!, :only => [:place, :newplace, :place_details,:placewithfilter, :place_old,:review]
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
		client_id = "SNJXcT5vmW12bA-ChqHVBg"
		client_secret = "fxeY2Wu0o8cQQg9rdbSWelTur87hTpsNBzqZefUBpydiIaZxOwVzY5gyPtpcA9bn"
		@array = Array.new
		if params[:flag] == "m"
			radius = params[:radius].to_f * 1609.344
			s_radius = params[:radius].to_f
		elsif params[:flag] == "k"
			radius = params[:radius].to_f * 1000
			s_radius = params[:radius].to_f * 0.621371
		else
			radius = 40000
			s_radius = 25
		end
		offset = (params[:page].to_i - 1) * 10
		puts offset
		limit = params[:limit].to_i
		@places =search("food", params[:latitude],params[:longitude],radius.to_i,params[:limit].to_i,offset)

		@response_count = Restaurant.near([params[:latitude], params[:longitude]], s_radius).size
		@response = Restaurant.near([params[:latitude], params[:longitude]], s_radius).paginate :page => params[:page], :per_page => limit
		#push google result in array 
  	if !@places['businesses'].blank?
  		@places['businesses'].each do |plc|
  			photo = Array.new
  			f = 0
  			if !plc['image_url'].blank?
  				image_url = plc['image_url']
					api_key = 'acc_893802e7beb855a'
					api_secret = 'f8a85e23f009ed1cf0cc3d509bc07f41'
					auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
				 	@img_check = RestClient.get "https://api.imagga.com/v1/tagging?url=#{image_url}", { :Authorization => auth }
				 	@img_check= ActiveSupport::JSON.decode(@img_check)
				 	puts @img_check
					@img_check['results'].each do |r|
						r['tags'].each do |t|
							if t['tag'] == "food"
								puts t['tag']
								f = 1
							end
						end
					end
  				photo << {photo_url: plc['image_url'], photoreference: plc['image_url']}
  			end
  			if f == 1
  				address1 = plc['location']['address1']
  				city = plc['location']['city']
  				state = plc['location']['state']
  				zip_code = plc['location']['zip_code']
  				address = ""
  				if !address1.blank? 
  						address = address1
  				end
  				if !city.blank?
  					address = address+","+city
  				end
  				if !state.blank?
  					address = address+","+state
  				end
  				if !zip_code.blank?
  					address = address+","+zip_code
  				end
	  			@array << {name: plc['name'], formatted_address: address, latitude: plc['coordinates']['latitude'], longitude: plc['coordinates']['longitude'], place_id: plc['id'], rating: plc['rating'], distance: plc['distance'], photos: photo , add_manual: false}  				
  			end
  		end
  	end
  # push local response in array

  	# if  @response.size > 0
  	# 	@response.each do |res|
  	# 		photo = Array.new
  	# 		db_photos = res.restaurant_photos.all
  	# 		if !db_photos.blank?
  	# 			db_photos.each do |ph|
  	# 				photo << {photo_url: ph.photo.url, photoreference: ph.id}
  	# 			end
  	# 			@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  	# 		end
  			
  		end
  	end


  	@sorted = @array.sort_by { |k| k[:distance] }
	end

	def place_old # with imagga api
		@key = "AIzaSyCQ9aGFwsgl4IsJqpY5HHdnDbTWBHyD_TQ"
	  type = "cafe"
	  radius = 600
	  @array = Array.new
	  @response_google=RestClient::Request.execute(method: :get, url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
                            timeout: 20, headers: {params: {key: @key, location: params[:location],:radius => radius, :type => type}})
	  @response_google = ActiveSupport::JSON.decode(@response_google)

    @response = Restaurant.near([params[:latitude], params[:longitude]], 40000)
  
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
									distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  								@array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
								end
							end
						end
  				end	
  			else
  				# distance = Geocoder::Calculations.distance_between([params[:latitude], params[:longitude]], [res['geometry']['location']['lat'],res['geometry']['location']['lng']])
  				# @array << {name: res['name'], formatted_address: res['formatted_address'], latitude: res['geometry']['location']['lat'], longitude: res['geometry']['location']['lng'], place_id: res['place_id'], rating: res['rating'], distance: distance, photos: photo , add_manual: false}
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
  					# url_c = "http://54.218.251.105:3000"+ph.photo.url
      	# 		@s_urls = RestClient.post "https://www.googleapis.com/urlshortener/v1/url/?key=AIzaSyBU_beRXw4pisGLzJLlwMAdKaBhj3XTYCY", {"longUrl" => url_c}.to_json, :content_type => "application/json"
  					# @s_urls = ActiveSupport::JSON.decode(@s_urls)
  				# 	image_url = "http://54.218.251.105:3000"+ph.photo.url
						# api_key = 'acc_61d09fb31788cb1'
						# api_secret = 'e818bc86ebe0f859b8d3a56233578ce0'
						# auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
					 # 	@img_check = RestClient.get "https://api.imagga.com/v1/tagging?url=#{image_url}", { :Authorization => auth }
					 # 	@img_check= ActiveSupport::JSON.decode(@img_check)
					 # 	puts @img_check
						# @img_check['results'].each do |r|
						# 	r['tags'].each do |t|
						# 		if t['tag'] == "food"
						# 			puts t['tag']
									
						# 		end
						# 	end
						# end
						photo << {photo_url: ph.photo.url, photoreference: ph.id}
  				end

  				@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  			else
  				@array << {name: res.name, formatted_address: res.formatted_address, latitude: res.latitude, longitude: res.longitude, place_id: res.id, rating: res.rating, distance: res.distance, photos: photo , add_manual: true}
  			end
  			
  		end
  	end


  	@sorted = @array.sort_by { |k| k[:distance] }


		respond_to do |format|
			        format.json{ render :json => { action: 'place_old',
			                        response: 'true',
			                        msg: 'ok',result: @sorted} }
			      end
	end

	def bearer_token
		client_id = "SNJXcT5vmW12bA-ChqHVBg"
		client_secret = "fxeY2Wu0o8cQQg9rdbSWelTur87hTpsNBzqZefUBpydiIaZxOwVzY5gyPtpcA9bn"
		api_host = "https://api.yelp.com"
		token_path = "/oauth2/token"
		grant_type = "client_credentials"

	  # Put the url together
	  url = api_host+token_path

	  # Build our params hash
	  params = {
	    client_id: client_id,
	    client_secret: client_secret,
	    grant_type: grant_type
	  }

	  response = HTTP.post(url, params: params)
	  parsed = response.parse

	  "#{parsed['token_type']} #{parsed['access_token']}"
	end

	def search(term, latitude,longitude,radius,limit,offset)
		api_host = "https://api.yelp.com"
		search_path = "/v3/businesses/search"
	  url = api_host+search_path
	  params = {
	    term: term,
	    latitude: latitude,
	    longitude: longitude,
	    radius: radius,
	    limit: limit,
	    offset:offset
	  }

	  response = HTTP.auth(bearer_token).get(url, params: params)
	  response.parse
	end
	def res_review(id)
	  url = "https://api.yelp.com/v3/businesses/"+id+"/reviews"
	  response = HTTP.auth(bearer_token).get(url)
	  response.parse
	end

	def placewithfilter # without imagga api
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

	def review
		@add_manual = params[:add_manual]
		if @add_manual == 'true'
			@res = Restaurant.find(params[:placeid])
			@res_reviews = @res.restaurant_reviews.all 
			@db_photos = @res.restaurant_photos.all
		else
			@res_reviews = res_review(params[:placeid])
		end
	end

end
