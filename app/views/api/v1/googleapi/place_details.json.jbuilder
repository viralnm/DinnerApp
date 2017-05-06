json.action "place_details"
json.response "true"
json.msg  "Successfully fetch your place details"
json.results do	
	if @add_manual == 'true'
		json.name @res.name
		json.formatted_address @res.formatted_address
		json.latitude @res.latitude
		json.longitude @res.longitude
		json.place_id @res.id
		json.rating @res.rating
		json.photos do
			if !@db_photos.blank?
				json.array! @db_photos.each do |ph|
					json.photo_url ph.photo.url
					json.photoreference ph.id
				end
			else
				json.array! @db_photos
			end
		end
		json.review do
			if !@res_reviews.blank?
				json.array! @res_reviews.each do |r|
					json.name r.name
					json.text r.text
					json.rating r.rating
					json.profile_photo_url r.photo.url
					json.time r.created_at
				end
			else
				json.array! @res_reviews
			end
		end
	else
		json.name @res['result']['name']
		json.formatted_address @res['result']['formatted_address']
		json.latitude @res['result']['geometry']['location']['lat']
		json.longitude @res['result']['geometry']['location']['lng']
		json.place_id @res['result']['place_id']
		json.rating @res['result']['rating']
		json.photos do
			if !@res['result']['photos'].blank?
				json.array! @res['result']['photos'].each do |ph|
					json.photo_url "https://maps.googleapis.com/maps/api/place/photo?maxwidth="+ph['width'].to_s+"&photoreference="+ph['photo_reference']+"&key="+@key.to_s
					json.photoreference ph['photo_reference']
				end
			else
				json.array! @res['result']['photos']
			end
		end
		json.review do
			if !@res['result']['reviews'].blank?
				json.array! @res['result']['reviews'].each do |r|
					json.name r['author_name']
					json.text r['text']
					json.rating r['rating']
					json.profile_photo_url r['profile_photo_url']
					json.time r['time']
				end
			else
				json.array! @res['result']['reviews']
			end
		end
	end
end