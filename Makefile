create-json:
	jsonnet specs/01-example.jsonnet --ext-str INSTANA_BASE_URL --ext-str INSTANA_USER_ID --ext-str INSTANA_API_TOKEN_RELATION_ID > 01-example.json
	jsonnet specs/02-all-widgets.jsonnet --ext-str INSTANA_BASE_URL --ext-str INSTANA_USER_ID --ext-str INSTANA_API_TOKEN_RELATION_ID > 02-all-widgets.json

create-dashboard: create-json
	curl --request POST --url ${INSTANA_BASE_URL}/api/custom-dashboard --header "authorization: apiToken ${INSTANA_API_TOKEN}" --header 'content-type: application/json' --data @01-example.json | jq -r .id
	curl --request POST --url ${INSTANA_BASE_URL}/api/custom-dashboard --header "authorization: apiToken ${INSTANA_API_TOKEN}" --header 'content-type: application/json' --data @02-all-widgets.json | jq -r .id

get-dashboard: require-dashboard-id
	curl -s -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}" |jq .
	#curl -s -I -w "%{http_code}" -o /dev/null -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}"

delete-dashboard: require-dashboard-id
	curl -X DELETE -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}"

#helper target
require-dashboard-id: 
	@if [ -n ${DASHBOARD_ID} ]; then echo "Provide a DASHBOARD_ID: make DASHBOARD_ID=123123123 get-dashboard"; fi;
