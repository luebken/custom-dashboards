const fetch = require('node-fetch');

const fs = require('fs');


const spec_dir = "./specs/";

const apiToken = process.env.INSTANA_API_TOKEN;
if (process.argv.length != 4 || !apiToken) {
    console.error('Usage: INSTANA_API_TOKEN=<INSTANA_API_TOKEN> node custom-dashboards.js <INSTANA_URL> <KUBERNETES_NAMESPACE_NAME>');
    return;
}
const url = process.argv[2];
const kubernetes_namespace_name = process.argv[3];

fs.readdir(spec_dir, (err, files) => {
    files.forEach(file => {
        let rawdata = fs.readFileSync(spec_dir + file);

        let json = replaceAndParseJson(rawdata.toString(), kubernetes_namespace_name, url)
        console.log(json)
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

// dummy jsonnet parser
// removes replaces KUBERNETES_NAMESPACE_NAME
// TODO read in variables from the json file
function replaceAndParseJson(jsonTemplate, kubernetes_namespace_name, url) {
    //var result = jsonTemplate.toString().replace(/local .*\n/g, '');
    //result = jsonTemplate.toString().replace(/\/\/.*\n/g, '');
    var result = jsonTemplate.toString().replace(/\$KUBERNETES_NAMESPACE_NAME/g, kubernetes_namespace_name);
    result = result.replace(/\$INSTANA_URL/g, url);
    return JSON.parse(result)
}


