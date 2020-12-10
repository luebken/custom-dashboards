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

        var kubernetes_namespace_name = "robot-shop"
        let json = replaceAndParseJson(rawdata.toString(), kubernetes_namespace_name)
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
// removes replaces kubernetes_namespace_name
// TODO read in variables from the json file
function replaceAndParseJson(jsonTemplate, kubernetes_namespace_name) {
    //var result = jsonTemplate.toString().replace(/local .*\n/g, '');
    //result = jsonTemplate.toString().replace(/\/\/.*\n/g, '');
    var result = jsonTemplate.toString().replace(/\$kubernetes_namespace_name/g, kubernetes_namespace_name);
    return JSON.parse(result)
}


