# Sample Custom Dashboards

While Instana provides curated dashboards to support common use-cases, there are situations where a [custom dashboard](https://www.instana.com/docs/custom_dashboards/) is the right tool for the job. 

This repository contains some sample custom dashboards which can be used as an inspiration what is possible or as a starting point for customization. These don't replace the built-in dashboards and support on these are community driven.

## Prerequisites

This upcoming script leverages the Instana [API](https://instana.github.io/openapi/). Access control is managed by [Access Tokens](https://www.instana.com/docs/api/web/#tokens). Ensure that the token has right set: "Creation of public custom dashboards". Set the API access token as an environment variable. e.g.:

    export INSTANA_API_TOKEN="123123123"

To query the API you need to set the base URL of the Istana tenant unit you want to create the dashboards in. e.g. 

    export INSTANA_BASE_URL="https://test-example.instana.io"

Finally to create a dashboard you need to aquire a `user_id` which is set as the owner of the dashboards you create. This user will be able to edit, delete and share the custom dashboard. There are several ways to the user-id. This repo has contains a script to list all [available user ids](available_user_ids.js). Set the `user_id` as an environment variable e.g. 

    export INSTANA_USER_ID="123123123"

## Install

The sample Dashboards are defined in the [specs](specs) folder. To install all dashboards with the default configuration run:
 
    node custom-dashboards.js

## Configure & Adapting Dashoards

The specs aber based on [Jsonnet](https://jsonnet.org/). To configure the individual dashboards see the respective `_config+` section.