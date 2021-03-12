# How to automate your custom dashbaords creation (DRAFT)

## Prerequisites

* jssonet

## Configuration Paramaters

* INSTANA_BASE_URL
* INSTANA_API_TOKEN
* MY_DEPLOYMENT_NAME (see below)


## Create the Jssonet

* Create a custom dashboard.
* Optional: share the dashboard
* Copy the dashboard definition via "Edit as Json"
* Save the file as `my-dashboard.jsonnet` and format it with `jsonnetfmt`

* remove the id and choose a new name e.g. my-dashboard

## Modularization

* Identify the Jsonnet sub-tree you want to extract. e.g. a `tagFilterExpression`:
```
...
metric: 'pools.G1 Eden Space',
tagFilterExpression: {
    name: 'kubernetes.deployment.name',
    type: 'TAG_FILTER',
    value: 'my-deployment',
    operator: 'EQUALS',
},
timeShift: 0
...
```
* Create a new file `filter-expressions.libsonnet`
* Copy over the Json Subtree
* Create a valid json by enclosing it with {}
* Give the key a represenative name and use "::" as the separator to export it:
```
{
  myTagFilterExpression:: {
    name: 'kubernetes.deployment.name',
    type: 'TAG_FILTER',
    value: 'my-deployment',
    operator: 'EQUALS',
  },
}
```
* In the main dashboard file import the extracted file at the top:
```
local filter = import 'filter-expressions.libsonnet';

{
  title: 'my-dashboard',
....

```
and use the extracted definition: 
```
...
metric: 'pools.G1 Eden Space',
tagFilterExpression: filter.myTagFilterExpression,
timeShift: 0
...
```

## Parameterization

* Choose what you want to parameterize. e.g. the name of the deployment. 
* Create an environement variable for it: `MY_DEPLOYMENT_NAME`
```
export MY_DEPLOYMENT_NAME=my-deployment
```
* Replace the value with `std.extVar('MY_DEPLOYMENT_NAME')`

```
{
  myTagFilterExpression:: {
    name: 'kubernetes.deployment.name',
    type: 'TAG_FILTER',
    value: std.extVar('MY_DEPLOYMENT_NAME'),
    operator: 'EQUALS',
  },
}
```

## Create Json

jsonnet my-dashboard.jsonnet --ext-str MY_DEPLOYMENT_NAME > my-dashboard.json

## Upload Dashboard

curl --request POST --url ${INSTANA_BASE_URL}/api/custom-dashboard --header "authorization: apiToken ${INSTANA_API_TOKEN}" --header 'content-type: application/json' --data @my-dashboard.json

