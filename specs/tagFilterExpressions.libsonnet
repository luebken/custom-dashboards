local _config = (import 'config-k8s.libsonnet');
{
  k8sNamespace:: {
    name: 'kubernetes.namespace.name',
    type: 'TAG_FILTER',
    value: _config.k8s.ns,
    operator: 'EQUALS',
  },
  k8sNamespaceAndPodLabel:: {
    logicalOperator: 'AND',
    elements: [
      {
        name: 'kubernetes.pod.label',
        type: 'TAG_FILTER',
        value: _config.k8s.pod.labelPrefix,
        operator: 'STARTS_WITH',
      },
      {
        name: 'kubernetes.namespace.name',
        type: 'TAG_FILTER',
        value: _config.k8s.ns,
        operator: 'EQUALS',
      },
    ],
    type: 'EXPRESSION',
  },
}
