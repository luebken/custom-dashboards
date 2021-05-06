echo deleting dashboard
echo $1
curl --request DELETE \
  --url $INSTANA_BASE_URL/api/custom-dashboard/$1 \
  --header "authorization: apiToken $INSTANA_API_TOKEN" \
  --header 'content-type: application/json'