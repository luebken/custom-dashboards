local _config = (import 'config-instana.libsonnet') + (import 'config-k8s.libsonnet');
local tagFilterExpression = (import 'tagFilterExpressions.libsonnet');
local metrics = (import 'metrics-infrastructure.libsonnet');
local accessRules = (import 'config-accessRules.libsonnet');
local widgetsDocker = (import 'widgets-docker.libsonnet');

{
  accessRules: accessRules.accessRules,

  title: 'Demo / Kubernetes / Namespace: ' + _config.k8s.ns + ' / Label: ' + _config.k8s.pod.labelPrefix,

  widgets: [
    {
      id: 'random-id-0000001',
      title: 'Demo / Kubernetes / Namespace: ' + _config.k8s.ns + ' / Label: ' + _config.k8s.pod.labelPrefix,
      width: 12,
      height: 6,
      x: 0,
      y: 0,
      type: 'markdown',
      config: 'This is a demo dashboard to highlight custom dashboards for a Kubernetes namespace and pod label.'
              + ' The original definition of the dashboard is: [01-k8s-podlabel.libsonnet](https://github.com/luebken/custom-dashboards/blob/master/specs/01-k8s-podlabel.libsonnet)\n\n'
              + 'Links:\n[Hosts Map](' + _config.instana.baseUrl + '/#/physical?q=entity.kubernetes.namespace%3A' + _config.k8s.ns + ') - [Container Map](' + _config.instana.baseUrl + '/#/container?q=entity.kubernetes.namespace%3A' + _config.k8s.ns + ') – [Analyze Calls](' + _config.instana.baseUrl + '/#/analyze;callList.dataSource=calls;callList.groupBy=(name~kubernetes.service.name~entity~DESTINATION)~;callList.tagFilter=!(name~kubernetes.namespace~value~' + _config.k8s.ns + '~operator~EQUALS~entity~DESTINATION)~;callList.showGraph=true;ua2=false)\n---',
    },
    widgetsDocker.dockerCpuTotalUsageForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 6,
    },
    {
      id: 'random-id-0000003',
      title: 'Docker CPU Usage ("' + _config.k8s.pod.labelPrefix + '")',
      width: 6,
      height: 13,
      x: 6,
      y: 6,
      type: 'chart',
      config: {
        y1: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: [
            {
              metric: 'cpu.total_usage',
              tagFilterExpression: tagFilterExpression.k8sNamespaceAndPodLabel,
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
    {
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
    {
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
    {
      id: 'random-id-0000006',
      title: 'Docker CPU Throttling',
      width: 6,
      height: 13,
      x: 0,
      y: 32,
      type: 'chart',
      config: {
        y1: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: std.map(function(o) o { tagFilterExpression: tagFilterExpression.k8sNamespace }, metrics.dockerCpuThrottlingCount),
        },
        y2: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: [],
        },
        type: 'TIME_SERIES',
      },
    },
    {
      id: 'random-id-0000007',
      width: 6,
      height: 13,
      x: 6,
      y: 32,
      title: 'Docker CPU Throttling ("' + _config.k8s.pod.labelPrefix + '")',
      type: 'chart',
      config: {
        type: 'TIME_SERIES',
        y1: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: std.map(function(o) o { tagFilterExpression: tagFilterExpression.k8sNamespaceAndPodLabel }, metrics.dockerCpuThrottlingCount),
        },
        y2: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: [],
        },
      },
    },
    {
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
    {
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
    {
      id: 'random-id-0000010',
      title: 'Docker Memory Usage',
      width: 6,
      height: 13,
      x: 0,
      y: 59,
      type: 'chart',
      config: {
        y1: {
          formatter: 'bytes.detailed',
          renderer: 'line',
          metrics: std.map(function(o) o { tagFilterExpression: tagFilterExpression.k8sNamespace }, metrics.dockerMemoryUsage),
        },
        y2: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: [],
        },
        type: 'TIME_SERIES',
      },
    },
    {
      id: 'random-id-0000011',
      title: 'Docker Memory Usage ("' + _config.k8s.pod.labelPrefix + '")',
      width: 6,
      height: 13,
      x: 6,
      y: 59,
      type: 'chart',
      config: {
        y1: {
          formatter: 'bytes.detailed',
          renderer: 'line',
          metrics: std.map(function(o) o { tagFilterExpression: tagFilterExpression.k8sNamespaceAndPodLabel }, metrics.dockerMemoryUsage),
        },
        y2: {
          formatter: 'number.detailed',
          renderer: 'line',
          metrics: [],
        },
        type: 'TIME_SERIES',
      },
    },
  ],
}
