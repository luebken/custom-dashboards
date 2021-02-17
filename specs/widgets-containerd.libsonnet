local _config = import 'config-k8s.libsonnet';
local metrics = import 'metrics-infrastructure.libsonnet';
local filter = import 'tagFilterExpressions.libsonnet';

{
  cpuTotalUsageForK8sNamespace: {
    id: 'containerd-id-0000002',
    title: 'Containerd CPU Usage (Total)',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespace.infra }, metrics.containerdCpuTotalUsage),
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },
  cpuTotalUsageForK8sPodLabel: {
    id: 'containerd-id-0000003',
    title: 'Containerd CPU Usage ("' + _config.k8s.pod.labelPrefix + '")',
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
            metric: 'cpu.total_usage',
            tagFilterExpression: filter.k8sNamespaceAndPodLabel,
            grouping: [
              {
                maxResults: 5,
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
            aggregation: 'MEAN',
            label: 'Mean',
            source: 'INFRASTRUCTURE_METRICS',
            type: 'containerd',
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
  cpuThrottlingCountForK8sNamespace: {
    id: 'containerd-id-0000006',
    title: 'Containerd CPU Throttling',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespace.infra }, metrics.containerdCpuThrottlingCount),
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },
  cpuThrottlingCountForK8sPodLabel: {
    id: 'containerd-id-0000007',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    title: 'Containerd CPU Throttling ("' + _config.k8s.pod.labelPrefix + '")',
    type: 'chart',
    config: {
      type: 'TIME_SERIES',
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespaceAndPodLabel }, metrics.containerdCpuThrottlingCount),
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
    },
  },
  memoryUsageForK8sNamespace: {
    id: 'containerd-id-0000010',
    title: 'Containerd Memory Usage',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'bytes.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespace.infra }, metrics.containerdMemoryUsage),
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
      type: 'TIME_SERIES',
    },
  },
  memoryUsageForK8sPodLabel:
    {
      id: 'containerd-id-0000011',
      title: 'Containerd Memory Usage ("' + _config.k8s.pod.labelPrefix + '")',
      width: '<NEEDS TO BE SET>',
      height: '<NEEDS TO BE SET>',
      x: '<NEEDS TO BE SET>',
      y: '<NEEDS TO BE SET>',
      type: 'chart',
      config: {
        y1: {
          formatter: 'bytes.detailed',
          renderer: 'line',
          metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespaceAndPodLabel }, metrics.containerdMemoryUsage),
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
