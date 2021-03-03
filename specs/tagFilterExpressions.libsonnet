local _config = (import 'config-k8s.libsonnet');
{

  //TODO needs proper filter / groupBy differentiation

  k8sNamespace:: {
    infra::
      {
        logicalOperator: 'AND',
        elements: [
          {
            name: 'kubernetes.namespace.name',
            type: 'TAG_FILTER',
            value: _config.k8s.ns,
            operator: 'EQUALS',
          },
          {
            name: 'kubernetes.cluster.name',
            type: 'TAG_FILTER',
            value: _config.k8s.cluster,
            operator: 'EQUALS',
          },
        ],
        type: 'EXPRESSION',
      },
    ap:: {
      name: 'kubernetes.namespace',
      type: 'TAG_FILTER',
      value: _config.k8s.ns,
      entity: 'DESTINATION',
      operator: 'EQUALS',
    },
    analyze:: 'tagFilterExpression=!(type~TAG*_FILTER~name~kubernetes.namespace~value~' + _config.k8s.ns + '~operator~EQUALS~entity~DESTINATION)(type~CONJUNCTION~logicalOperator~AND)(type~TAG*_FILTER~name~kubernetes.cluster.name~operator~EQUALS~value~'+_config.k8s.cluster+'~entity~DESTINATION)~',
    analyzeGroupBy:: 'groupBy=(groupbyTagEntity~DESTINATION~groupbyTag~kubernetes.pod.label~groupbyTagSecondLevelKey~'+_config.k8s.pod.labelKey+')~;',
    dfq:: 'entity.kubernetes.namespace:' + _config.k8s.ns + '%20entity.kubernetes.cluster.label:' + _config.k8s.cluster,
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
      {
        name: 'kubernetes.cluster.name',
        type: 'TAG_FILTER',
        value: _config.k8s.cluster,
        operator: 'EQUALS',
      },
    ],
    type: 'EXPRESSION',
  },
}
