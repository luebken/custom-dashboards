const fetch = require('node-fetch');

// Small script which lists all available user_ids 

const apiToken = process.env.INSTANA_API_TOKEN;
if (process.argv.length != 3 || !apiToken) {
    console.error('Usage: node available_user_ids.js <INSTANA_URL>');
    console.error('also ENV INSTANA_API_TOKEN need to be set');
    return;
}
const url = process.argv[2];

(async () => {
    const response = await fetch(`${url}/api/custom-dashboard/shareable-users`, {
        method: 'GET',
        headers: {
            authorization: `apiToken ${apiToken}`,
            'content-type': 'application/json'
        }
    });

    console.log('Status code:', response.status);
    const responseBody = await response.text();
    const responseJson = JSON.parse(responseBody)

    console.log('Response body:', responseJson);
})().catch(e => console.error('Error', e));