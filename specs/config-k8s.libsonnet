// K8s filters.
{
  k8s: {
    ns: 'robot-shop',  // Change to your namespace.
    pod: {
      labelPrefix: 'app=',  // Change to any preferred pod label prefix: e.g. app.kubernetes.io/name or app.kubernetes.io/version
    },
  },
}