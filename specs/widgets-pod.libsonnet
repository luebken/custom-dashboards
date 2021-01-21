local _config = import 'config-k8s.libsonnet';
local metrics = import 'metrics-infrastructure.libsonnet';
local tagFilterExpression = import 'tagFilterExpressions.libsonnet';

{
  cpuRequestsAndLimitsForK8sNamespace: {
    id: 'random-id-0000004',
    title: 'Pod CPU Requests & Limits (Total)',
    width: 6,
    height: 13,
    x: 0,
    y: 19,
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'stackedBar',
        metrics: [
          {
            metric: 'cpuRequests',
            tagFilterExpression: tagFilterExpression.k8sNamespace,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Requests',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
          {
            metric: 'cpuLimits',
            tagFilterExpression: tagFilterExpression.k8sNamespace,
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
    width: 6,
    height: 13,
    x: 6,
    y: 19,
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'stackedBar',
        metrics: [
          {
            metric: 'cpuRequests',
            tagFilterExpression: tagFilterExpression.k8sNamespaceAndPodLabel,
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
    width: 6,
    height: 13,
    x: 0,
    y: 45,
    type: 'chart',
    config: {
      y1: {
        formatter: 'bytes.detailed',
        renderer: 'stackedBar',
        metrics: [
          {
            metric: 'memoryRequests',
            tagFilterExpression: tagFilterExpression.k8sNamespace,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'Memory Requests',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
          {
            metric: 'memory.limit',
            tagFilterExpression: tagFilterExpression.k8sNamespace,
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
    width: 6,
    height: 13,
    x: 6,
    y: 45,
    type: 'chart',
    config: {
      y1: {
        formatter: 'bytes.detailed',
        renderer: 'stackedBar',
        metrics: [
          {
            metric: 'memoryRequests',
            tagFilterExpression: tagFilterExpression.k8sNamespaceAndPodLabel,
            timeShift: 0,
            aggregation: 'SUM',
            label: 'CPU Memory',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'kubernetesPod',
          },
          {
            metric: 'memoryLimits',
            tagFilterExpression: tagFilterExpression.k8sNamespaceAndPodLabel,
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
