json.action "googleapi_place"
if @sorted.size > 0
	json.response "true"
	json.msg  "Successfully fetch your googleapi_place details"
else
	json.response "false"
	json.msg  "places are not available."
end
json.total @places['total']
json.database_total @response_count
json.results @sorted

