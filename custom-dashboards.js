const fetch = require('node-fetch');

const fs = require('fs');


const spec_dir = "./specs/";

const apiToken = process.env.INSTANA_API_TOKEN;
if (process.argv.length != 3 || !apiToken) {
    console.error('Usage: INSTANA_API_TOKEN=<INSTANA_API_TOKEN> node custom-dashboards.js <INSTANA_API_URL>');
    return;
}
const url = process.argv[2];


fs.readdir(spec_dir, (err, files) => {
    files.forEach(file => {
        let rawdata = fs.readFileSync(spec_dir + file);
        let json = JSON.parse(rawdata);
        console.log("Creating dashboard defined in " + file);
        (async () => {
            const response = await fetch(`${url}/api/custom-dashboard`, {
                method: 'POST',
                headers: {
                    authorization: `apiToken ${apiToken}`,
                    'content-type': 'application/json'
                },
                body: JSON.stringify(json)
            });

            console.log('Status code:', response.status);
            const responseBody = await response.text();
            console.log('Response body:', responseBody);
        })().catch(e => console.error('Error', e));
    });
});


