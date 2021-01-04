const fetch = require('node-fetch');
const fs = require('fs');

const spec_dir = "./specs/";

const apiToken = process.env.INSTANA_API_TOKEN;
const user_id = process.env.INSTANA_USER_ID;
if (process.argv.length != 5 || !apiToken || !user_id) {
    console.error('Usage: node custom-dashboards.js <INSTANA_URL> <KUBERNETES_NAMESPACE_NAME> <KUBERNETES_POD_LABEL>');
    console.error('also envs INSTANA_API_TOKEN and INSTANA_USER_ID need to be set');
    return;
}
const url = process.argv[2];
const kubernetes_namespace_name = process.argv[3];
const kubernetes_pod_label = process.argv[4];

fs.readdir(spec_dir, (err, files) => {
    files.forEach(file => {
        const isJsonExt = file.substr(file.lastIndexOf(".")) == ".json"
        if (isJsonExt) {
        let rawdata = fs.readFileSync(spec_dir + file);

        let json = replaceAndParseJson(rawdata.toString(), kubernetes_namespace_name, kubernetes_pod_label, url, user_id)
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
        }
    });
});

// Poormans templating. Removes replaces $-Variables with specified values.
// TODO read availble variables from the json file
function replaceAndParseJson(jsonTemplate, kubernetes_namespace_name, kubernetes_pod_label, url, user_id) {
    //var result = jsonTemplate.toString().replace(/local .*\n/g, '');
    //result = jsonTemplate.toString().replace(/\/\/.*\n/g, '');
    var result = jsonTemplate.toString().replace(/\$KUBERNETES_NAMESPACE_NAME/g, kubernetes_namespace_name);
    result = result.replace(/\$KUBERNETES_POD_LABEL/g, kubernetes_pod_label);
    result = result.replace(/\$INSTANA_URL/g, url);
    result = result.replace(/\$INSTANA_USER_ID/g, user_id);
    return JSON.parse(result)
}


