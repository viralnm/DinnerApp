json.action "googleapi_place"
if @response['results'].size > 0
	json.response "true"
	json.msg  "Successfully fetch your googleapi_place details"
else
	json.response "false"
	json.msg  "places are not available."
end
json.results do
	if @response['results'].size > 0
		json.array! @response['results'].each do |res|
			json.name res['name']
			json.formatted_address res['formatted_address']
			json.latitude res['geometry']['location']['lat']
			json.longitude res['geometry']['location']['lng']
			json.place_id res['place_id']
			json.rating res['rating']
			json.photos do
				if res['photos'].size > 0
					json.array! res['photos'].each do |ph|
						json.photo_url "https://maps.googleapis.com/maps/api/place/photo?maxwidth="+ph['width'].to_s+"&photoreference="+ph['photo_reference']+"&key="+@key.to_s
					end
				else
					json.array! res['photos']
				end
			end
		end
	else
		json.array! @response['results']
	end
end