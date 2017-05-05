json.action "googleapi_place"
if @sorted.size > 0
	json.response "true"
	json.msg  "Successfully fetch your googleapi_place details"
	json.results_google @sorted
else
	json.response "false"
	json.msg  "places are not available."
end

