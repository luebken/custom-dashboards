curl --request GET \
  --url $INSTANA_BASE_URL/api/custom-dashboard \
  --header "authorization: apiToken $INSTANA_API_TOKEN" \
  --header 'content-type: application/json' | jq -r .[].id