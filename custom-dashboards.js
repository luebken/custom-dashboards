const fetch = require('node-fetch');

const api_token = process.env.INSTANA_API_TOKEN
if (process.argv.length != 3 || !api_token) {
    console.error("Usage: INSTANA_API_TOKEN=<INSTANA_API_TOKEN> node custom-dashboards.js <INSTANA_API_URL>")
    return
}
const api_url = process.argv[2]

const body = {
    "id": "vckk-dYcRU6z04QP37F8cQA",
    "title": "Test matthias",
    "accessRules": [
        {
            "accessType": "READ_WRITE",
            "relationType": "USER",
            "relatedId": "5ee8a3e8cd70020001ecb007"
        }
    ],
    "widgets": [
        {
            "id": "uzmv5wyiJOAlrP8vA",
            "title": "test",
            "width": 1,
            "height": 1,
            "x": 0,
            "y": 0,
            "type": "markdown",
            "config": "test"
        }
    ],
    "writable": true
}


console.log("Post")
fetch(api_url + 'custom-dashboard', {
    method: 'post',
    body: JSON.stringify(body),
    headers: {
        'authorization': 'apiToken ' + api_token,
        'content-type': 'application/json'
    },
})
    .then(res => res.json())
    .then(json => console.log(json));
