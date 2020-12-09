const request = require('request');

const api_token = process.env.INSTANA_API_TOKEN
if (process.argv.length != 3 || !api_token) {
    console.error("Usage: INSTANA_API_TOKEN=<INSTANA_API_TOKEN> node custom-dashboards.js <INSTANA_API_URL>")
    return
}
const api_url = process.argv[2]

function buildRequestOptions() {
    const body = {
        "id": "vckk-dYcRU6z04QP37F8cQ",
        "title": "Test matthias",
        "accessRules": [
          {
            "accessType": "WRITE",
            "relationType": "USER",
            "relatedId": "5ee8a3e8cd70020001ecb007"
          }
        ],
        "widgets": [
          {
            "id": "uzmv5wyiJOAlrP8v",
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



    const options = {
        url: api_url + 'custom-dashboard',
        headers: {
            'authorization': 'apiToken ' + api_token,
            'content-type': 'application/json'
        },
        body: JSON.stringify(body)
    };
    return options
}


const options = buildRequestOptions()

console.log("Post")
request.post(options, function (error, response, body) {
    if (error) console.error('error:', error);
    if (response.statusCode != 200) {
        console.debug('StatusCode:', response && response.statusCode);
        console.debug('Body:', body);
        return
    }
    var body = JSON.parse(body)
    if (!body.data || !body.data.items) {
        console.error("Unexpected result: ", body)
        return
    }

    console.log(body)
});



