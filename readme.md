# Sample Custom Dashboards

While Instana provides curated dashboards to support common use-cases, there are situations where a [custom dashboard](https://www.instana.com/docs/custom_dashboards/) is the right tool for the job. 

This repository contains some sample custom dashboards which can be used as an inspiration what is possible or as a starting point for customization. These don't replace the built-in dashboards and support on these are community driven.

## Prerequisites

This script leverages the Instana [API](https://instana.github.io/openapi/). Access control is managed by [Access Tokens](https://www.instana.com/docs/api/web/#tokens). Ensure that the token has right set: "Creation of public custom dashboards". Set the API access token as an environment variable. e.g.:

    export INSTANA_API_TOKEN="123123123"

To query the API you need to set the base URL of the Istana tenant unit you want to create the dashboards in. e.g. 

    export INSTANA_BASE_URL="https://test-example.instana.io"

Finally to create a dashboard you need to aquire a `user_id` which is set as the owner of the dashboards you create. This user will be able to edit, delete and share the custom dashboard. There are several ways to the user-id. Set the `user_id` as an environment variable e.g. 

    export INSTANA_USER_ID="123123123"

## Configure & Adapting Dashoards

The specs aber based on [Jsonnet](https://jsonnet.org/). To configure the individual dashboards see the respective `_config+` section.


## Install

As the specs are pure Jsonnet you can also use CLI to create the dashboards:

    # Install Jsonnet. Eg.
    $ brew install go-jsonnet
    
    # Create JSON Payoload for the API
    $ jsonnet specs/01-k8s-podlabel.libsonnet --ext-str INSTANA_BASE_URL --ext-str INSTANA_USER_ID --ext-str INSTANA_API_TOKEN_RELATION_ID > 01-k8s-podlabel.json

    # Create dashboard
    $ DASHBOARD_ID=$(curl -s --request POST --url $INSTANA_BASE_URL/api/custom-dashboard --header "authorization: apiToken $INSTANA_API_TOKEN" --header 'content-type: application/json' --data @01-k8s-podlabel.json | jq -r .id)
    
    # View dashboard in browser
    $ open "$INSTANA_BASE_URL/#/customDashboards/view;dashboardId=$DASHBOARD_ID"
    
## Delete

    # Delete the dashboard    
    $ curl -I -X "DELETE" -H "authorization: apiToken $INSTANA_API_TOKEN" "$INSTANA_BASE_URL/api/custom-dashboard/$DASHBOARD_ID"
    # Ensure dashboards was deleted: Should return 404
    $ curl -I -H "authorization: apiToken $INSTANA_API_TOKEN" "$INSTANA_BASE_URL/api/custom-dashboard/$DASHBOARD_ID"

    # Test the status code
    $ DASHBOARD_GET=$(curl -s -I -w "%{http_code}" -o /dev/null -H "authorization: apiToken $INSTANA_API_TOKEN" "$INSTANA_BASE_URL/api/custom-dashboard/$DASHBOARD_ID")
    $ test $DASHBOARD_GET==404