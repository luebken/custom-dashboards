create-json:
	jsonnet specs/01-k8s-podlabel.libsonnet --ext-str INSTANA_BASE_URL --ext-str INSTANA_USER_ID --ext-str INSTANA_API_TOKEN_RELATION_ID > 01-k8s-podlabel.json

create-dashboard:
	curl --request POST --url ${INSTANA_BASE_URL}/api/custom-dashboard --header "authorization: apiToken ${INSTANA_API_TOKEN}" --header 'content-type: application/json' --data @01-k8s-podlabel.json | jq -r .id

require-dashboard-id:
	@if [ -n ${DASHBOARD_ID} ]; then echo "Provide a DASHBOARD_ID: make DASHBOARD_ID=123123123 get-dashboard"; fi;

get-dashboard: require-dashboard-id
	curl -s -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}" |jq .
	#curl -s -I -w "%{http_code}" -o /dev/null -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}"

delete-dashboard: require-dashboard-id
	curl -X DELETE -H "authorization: apiToken ${INSTANA_API_TOKEN}" "${INSTANA_BASE_URL}/api/custom-dashboard/${DASHBOARD_ID}"

