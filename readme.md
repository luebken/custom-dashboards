These are a set of custom dashboards that are assumed to be useful for others. There is no guarantee / support on these. Use at you own will.

This tool users the [Custom Dashboards API](https://instana.github.io/openapi/#tag/Custom-Dashboards) to create the dashboards. 

To get it running you need: 
* Your own user_id and set it as env=INSTANA_USER_ID 
* A Instana API token which is allowed to create custom dashboards and set it as env=INSTANA_API_TOKEN
 
To run it: 
    node custom-dashboards.js <INSTANA_URL> <KUBERNETES_NAMESPACE_NAME>