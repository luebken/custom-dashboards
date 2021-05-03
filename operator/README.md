# Operator

This folder contains code to automate the creation of custom-dashbaords in

## Testing

    # Setup Cluster
    kind delete cluster
    kind create cluster --image=kindest/node:v1.19.1

    # Setup Kubebuilder
    kubebuilder init --domain custom.instana.io --repo custom.instana.io/customdashboard