# Sample Custom Dashboards

While Instana provides curated dashboards to support common use-cases, there are situations where a (custom dashboard)[https://www.instana.com/docs/custom_dashboards/] is the right tool for the job. 

This repository contains some sample custom dashboards which can be used as an inspiration what is possible or as a starting point for customization. These don't replace the built-in dashboards and support on these are community driven.

## Prerequsites

This upcoming script leverages the Instana (API)[https://instana.github.io/openapi/]. Access control is managed by (Access Tokens)[https://www.instana.com/docs/api/web/#tokens]. Set the API access token as an environment variable. e.g.:

    export INSTANA_API_TOKEN="123123123"

To create a dashboard you need to aquire a `user_id` which is set as the owner of the dashboards you create. This user will be able to edit, delete and share the custom dashboard. There are several ways to the user-id. This repo has contains a script to list all [available user ids](available_used_ids.js). Set the `user_id` as an environment variable e.g. 

    export INSTANA_USER_ID="123123123"

## Install All Dashboards

The sample Dashboards are defined in the [specs](specs) folder. To install all dashboards run: 
 
    node custom-dashboards.js <INSTANA_URL> <KUBERNETES_NAMESPACE_NAME> <KUBERNETES_POD_LABEL>
