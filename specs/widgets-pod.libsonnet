local _config = import 'config-k8s.libsonnet';
local metrics = import 'metrics-infrastructure.libsonnet';
local filter = import 'tagFilterExpressions.libsonnet';

{
  cpuRequestsAndLimitsForK8sNamespace: {
    id: 'random-id-0000004',
    title: 'Pod CPU Requests & Limits (Total)',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [
          {
            metric: 'cpuRequests',
            tagFilterExpression: filter.k8sNamespace.infra,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Requests',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
          {
            metric: 'cpuLimits',
            tagFilterExpression: filter.k8sNamespace.infra,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Limits',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
        ],
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },

  cpuRequestsForK8sPodLabels: {
    id: 'random-id-0000005',
    title: 'Pod CPU Requests ("' + _config.k8s.pod.labelPrefix + '")',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [
          {
            metric: 'cpuRequests',
            tagFilterExpression: filter.k8sNamespaceAndPodLabel,
            grouping: [
              {
                maxResults: 10,
                by: {
                  groupbyTag: 'kubernetes.pod.label',
                  groupbyTagEntity: 'NOT_APPLICABLE',
                  groupbyTagSecondLevelKey: '',
                },
                includeOthers: true,
                direction: 'DESC',
              },
            ],
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Requests',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
        ],
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },

  memoryRequestsAndLimitsForK8sNamespace: {
    id: 'random-id-0000008',
    title: 'Pod Memory Requests & Limits',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'bytes.detailed',
        renderer: 'line',
        metrics: [
          {
            metric: 'memoryRequests',
            tagFilterExpression: filter.k8sNamespace.infra,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'Memory Requests',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
          {
            metric: 'memory.limit',
            tagFilterExpression: filter.k8sNamespace.infra,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'Memory Limits',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'docker',
          },
        ],
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },

  memoryRequestsAndLimitsForK8sPodLabel: {
    id: 'random-id-0000009',
    title: 'Pod Memory Requests & Limits ("' + _config.k8s.pod.labelPrefix + '")',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'bytes.detailed',
        renderer: 'line',
        metrics: [
          {
            metric: 'memoryRequests',
            tagFilterExpression: filter.k8sNamespaceAndPodLabel,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Memory',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
          {
            metric: 'memoryLimits',
            tagFilterExpression: filter.k8sNamespaceAndPodLabel,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Limits',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
        ],
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },


}
