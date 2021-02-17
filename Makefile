# Creates an example json from the jsonnet template
create-example-json:
	jsonnet specs/01-example.jsonnet --ext-str INSTANA_BASE_URL --ext-str INSTANA_USER_ID --ext-str INSTANA_API_TOKEN_RELATION_ID > 01-example.json

# Creates the dashboard by calling the Instana API
create-example-dashboard: create-example-json
	curl --request POST --url ${INSTANA_BASE_URL}/api/custom-dashboard --header "authorization: apiToken ${INSTANA_API_TOKEN}" --header 'content-type: application/json' --data @01-example.json | jq -r .id

get-all-dashboards:
	curl -s -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard" |jq .[].id

# Gets the dashboard to verify the json created in the Instana backend
get-dashboard: require-dashboard-id
	curl -s -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}" |jq .


# Deletes a dashboard
delete-dashboard: require-dashboard-id
	curl -X DELETE -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}"

# helper target
require-dashboard-id: 
	@if [ -n ${DASHBOARD_ID} ]; then echo "Provide a DASHBOARD_ID: make DASHBOARD_ID=123123123 get-dashboard"; fi;
