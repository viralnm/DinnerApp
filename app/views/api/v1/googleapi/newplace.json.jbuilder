json.action "googleapi_place"
if @response.size > 0
	json.response "true"
	json.msg  "Successfully fetch your googleapi_place details"
else
	json.response "false"
	json.msg  "places are not available."
end
json.results @response
