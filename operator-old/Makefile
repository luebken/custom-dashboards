setup:
	kubectl create clusterrolebinding default-view --clusterrole=customdashboard-crd --serviceaccount=default:default
	kubectl create secret generic cd-mgr-secret --from-literal=INSTANA_API_TOKEN=$INSTANA_API_TOKEN --from-literal=INSTANA_BASE_URL=$INSTANA_BASE_URL
	kubectl create -f configmap.yaml

build:
	GOOS=linux go build -o ./cd-mgr .
	docker build -t luebken/cd-mgr .
	docker push luebken/cd-mgr

test:
	docker run --env INSTANA_BASE_URL=$(INSTANA_BASE_URL) --env INSTANA_API_TOKEN=$(INSTANA_API_TOKEN)  luebken/cd-mgr 

apply:
	kubectl apply -f deployment.yaml
