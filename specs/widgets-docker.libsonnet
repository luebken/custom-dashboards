local tagFilterExpression = (import 'tagFilterExpressions.libsonnet');
local metrics = (import 'metrics-infrastructure.libsonnet');

{
  dockerCpuTotalUsageForK8sNamespace: {
    id: 'random-id-0000002',
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
        metrics: std.map(function(o) o { tagFilterExpression: tagFilterExpression.k8sNamespace }, metrics.dockerCpuTotalUsage),
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
