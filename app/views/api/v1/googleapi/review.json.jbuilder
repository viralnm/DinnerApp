json.action "place review"
if !@res_reviews.blank?
	json.response "true"
	json.msg  "Successfully fetch your placereview details"
else
	json.response "false"
	json.msg  "reviews are not available."
end
json.results do
	if @add_manual == 'true'
		
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
		
	else
		
		if !@res_reviews['reviews'].blank?
			json.array! @res_reviews['reviews'].each do |r|
				json.name r['user']['name']
				json.text r['text']
				json.rating r['rating']
				json.profile_photo_url r['user']['image_url']
				json.time r['time_created']
			end
		else
			json.array! @res_reviews['reviews']
		end
		
	end
end
