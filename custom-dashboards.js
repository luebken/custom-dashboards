import { Jsonnet } from "@hanazuki/node-jsonnet";
const jsonnet = new Jsonnet();
import fs from 'fs';
import fetch from 'node-fetch';

const spec_dir = "./specs/";

const apiToken = process.env.INSTANA_API_TOKEN;
const user_id = process.env.INSTANA_USER_ID;
const baseUrl = process.env.INSTANA_BASE_URL;

if (process.argv.length != 2 || !apiToken || !user_id || !baseUrl) {
    console.error('Usage: node custom-dashboards.js');
    console.error('The envs INSTANA_BASE_URL, INSTANA_API_TOKEN and INSTANA_USER_ID need to be set');
    process.exit(1);
}

fs.readdir(spec_dir, (err, files) => {
    files.forEach(file => {
        const isJsonExt = file.substr(file.lastIndexOf(".")) == ".libsonnet"
        if (isJsonExt) {
            let rawdata = fs.readFileSync(spec_dir + file);
            jsonnet.extString("INSTANA_BASE_URL", baseUrl)
            jsonnet.extString("INSTANA_USER_ID", user_id)
            jsonnet.evaluateSnippet(rawdata.toString())
                .then(jsonString => {
                    (async () => {

                        const apiEndpoint = `${baseUrl}/api/custom-dashboard`
                        console.log("Quering endpoint:", apiEndpoint)
                        const response = await fetch(apiEndpoint, {
                            method: 'POST',
                            headers: {
                                authorization: `apiToken ${apiToken}`,
                                'content-type': 'application/json'
                            },
                            body: jsonString //JSON.stringify(json)
                        });
                        console.log('Status code:', response.status);
                        const responseBody = await response.text();
                        if (response.status != "200") {
                            console.log('Response:', response);
                        } else {
                            const jsonResponse = JSON.parse(responseBody);
                            const linkToDashboard = baseUrl + "/#/customDashboards/view;dashboardId=" + jsonResponse.id
                            console.log('Created dashboard at:', linkToDashboard);
                        }
                    })().catch(e => console.error('Error', e));

                });
            console.log("Creating dashboard defined in " + file);
        }

    });
});

