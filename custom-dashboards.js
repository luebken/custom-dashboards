const fetch = require('node-fetch');

const apiToken = process.env.INSTANA_API_TOKEN;
if (process.argv.length != 3 || !apiToken) {
  console.error('Usage: INSTANA_API_TOKEN=<INSTANA_API_TOKEN> node custom-dashboards.js <INSTANA_API_URL>');
  return;
}
const url = process.argv[2];

(async () => {
  const response = await fetch(`${url}/api/custom-dashboard`, {
    method: 'POST',
    headers: {
      authorization: `apiToken ${apiToken}`,
      'content-type': 'application/json'
    },
    body: JSON.stringify({
      title: 'Test Matthias Generated Dashboard',
      accessRules: [
        {
          accessType: 'READ_WRITE',
          relationType: 'USER',
          relatedId: '5ee8a3e8cd70020001ecb007'
        }
      ],
      widgets: [
        {
          id: Math.random().toString(36).substring(7),
          title: 'Test Widget Title',
          width: 1,
          height: 1,
          x: 0,
          y: 0,
          type: 'markdown',
          config: 'Test markdown: ' + new Date()
        }
      ]
    })
  });

  console.log('Status code:', response.status);
  const responseBody = await response.text();
  console.log('Response body:', responseBody);
})().catch(e => console.error('Error', e));
