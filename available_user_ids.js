const fetch = require('node-fetch');

// Small script which lists all available user_ids 

const apiToken = process.env.INSTANA_API_TOKEN;
const baseUrl = process.env.INSTANA_BASE_URL;
if (process.argv.length != 2 || !apiToken || !baseUrl) {
    console.error('Usage: node available_user_ids.js');
    console.error('ENVs INSTANA_API_TOKEN & INSTANA_BASE_URL need to be set');
    return;
}

(async () => {
    const apiEndpoint = `${baseUrl}/api/custom-dashboard/shareable-users`
    console.log("Quering endpoint:", apiEndpoint)
    const response = await fetch(apiEndpoint, {
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