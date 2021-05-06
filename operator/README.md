# Operator

This folder contains an Operator to automate the creation of custom-dashbaords by leveraging a Kubernetes Custom Resource

## Testing

    # Setup Cluster
    kind delete cluster
    kind create cluster --image=kindest/node:v1.19.1

    # Kubebuilder scaffolding: https://kubebuilder.io/quick-start.html  
    kubebuilder init --domain instana.io --repo github.com/luebken/custom-dashboards
    kubebuilder create api --group custom --version v1 --kind Dashboard
    make install
    make run
    kubectl apply -f config/samples/
    make docker-build docker-push
    make deploy


## TODOs

[X] Create Dashboard in Instana for a new CRD
[X] Delete Dashboard in Instana for a deleted CRD

[ ] Update Dashboard in Instana for an update CRD
[ ] CRUD a CRD for a Dashboard created in Instana
