local _config = import 'config-k8s.libsonnet';
local metrics = import 'metrics-infrastructure.libsonnet';
local filter = import 'tagFilterExpressions.libsonnet';

{
  cpuTotalUsageForK8sNamespace: {
    id: 'docker-id-0000002',
    title: 'Docker CPU Usage (Total)',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespace.infra }, metrics.dockerCpuTotalUsage),
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
    id: 'docker-id-0000003',
    title: 'Docker CPU Usage ("' + _config.k8s.pod.labelPrefix + '")',
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
  cpuThrottlingCountForK8sNamespace: {
    id: 'docker-id-0000006',
    title: 'Docker CPU Throttling',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespace.infra }, metrics.dockerCpuThrottlingCount),
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
    id: 'docker-id-0000007',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    title: 'Docker CPU Throttling ("' + _config.k8s.pod.labelPrefix + '")',
    type: 'chart',
    config: {
      type: 'TIME_SERIES',
      y1: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespaceAndPodLabel }, metrics.dockerCpuThrottlingCount),
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
    },
  },
  memoryUsageForK8sNamespace: {
    id: 'docker-id-0000010',
    title: 'Docker Memory Usage',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'bytes.detailed',
        renderer: 'line',
        metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespace.infra }, metrics.dockerMemoryUsage),
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
      id: 'docker-id-0000011',
      title: 'Docker Memory Usage ("' + _config.k8s.pod.labelPrefix + '")',
      width: '<NEEDS TO BE SET>',
      height: '<NEEDS TO BE SET>',
      x: '<NEEDS TO BE SET>',
      y: '<NEEDS TO BE SET>',
      type: 'chart',
      config: {
        y1: {
          formatter: 'bytes.detailed',
          renderer: 'line',
          metrics: std.map(function(o) o { tagFilterExpression: filter.k8sNamespaceAndPodLabel }, metrics.dockerMemoryUsage),
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
