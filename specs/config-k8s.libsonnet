// K8s filters.
{
  k8s: {
    ns: 'robot-shop',  // Change to your namespace.
    cluster: 'mdl-cluster',  // Change to your cluster.
    pod: {
      labelPrefix: 'service=',  // Change to any preferred pod label prefix: e.g. app.kubernetes.io/name or app.kubernetes.io/version
      labelKey: 'service',  // Change to any preferred pod label prefix: e.g. app.kubernetes.io/name or app.kubernetes.io/version
    },
  },
}