local _config = (import 'config-instana.libsonnet') + (import 'config-k8s.libsonnet');
local metrics = import 'metrics-infrastructure.libsonnet';
local accessRules = import 'config-accessRules.libsonnet';
local widgetsDocker = import 'widgets-docker.libsonnet';
local widgetsPod = import 'widgets-pod.libsonnet';
local widgetsServices = import 'widgets-services.libsonnet';
local filter = import 'tagFilterExpressions.libsonnet';

{
  accessRules: accessRules.accessRules,

  title: '🍿 Demo / Kubernetes / Namespace: ' + _config.k8s.ns + ' / Label: ' + _config.k8s.pod.labelPrefix,

  widgets: [
    {
      id: 'random-id-0000001',
      title: '🍿 Demo / Kubernetes / Namespace: ' + _config.k8s.ns + ' / Label: ' + _config.k8s.pod.labelPrefix,
      width: 12,
      height: 6,
      x: 0,
      y: 0,
      type: 'markdown',
      config: '![Image](https://instana.io/assets/2122732687/favicon-16x16.png) This is a demo dashboard to highlight custom dashboards for a Kubernetes namespace __' + _config.k8s.ns + '__ on the cluster __' + _config.k8s.cluster + '__ and for the pods __' + _config.k8s.pod.labelPrefix + '__. The original definition of the dashboard can be found [here](https://github.com/luebken/custom-dashboards/).\n\n'
              + 'Links:\n[Hosts Map](' + _config.instana.baseUrl + '/#/physical?q=entity.kubernetes.namespace%3A' + _config.k8s.ns + '%20entity.kubernetes.cluster.label%3A' + _config.k8s.cluster + ') - [Container Map](' + _config.instana.baseUrl + '/#/container?q=' + filter.k8sNamespace.dfq + ') – [Analyze Calls](' + _config.instana.baseUrl + '/#/analyze;dataSource=calls;' + filter.k8sNamespace.analyze + ';' + filter.k8sNamespace.analyzeGroupBy + ')\n---',
    },

    widgetsServices.callsForK8sNamespace {
      width: 4,
      height: 12,
      x: 0,
      y: 6,
    },
    widgetsServices.latencyForK8sNamespace {
      width: 4,
      height: 12,
      x: 4,
      y: 6,
    },
    widgetsServices.latencyForK8sNamespaceByLabel {
      width: 4,
      height: 12,
      x: 8,
      y: 6,
    },

    widgetsDocker.cpuTotalUsageForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 19,
    },
    widgetsDocker.cpuTotalUsageForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 19,
    },

    widgetsPod.cpuRequestsAndLimitsForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 32,
    },
    widgetsPod.cpuRequestsForK8sPodLabels {
      width: 6,
      height: 13,
      x: 6,
      y: 32,
    },

    widgetsDocker.cpuThrottlingCountForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 45,
    },
    widgetsDocker.cpuThrottlingCountForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 45,
    },

    widgetsPod.memoryRequestsAndLimitsForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 59,
    },
    widgetsPod.memoryRequestsAndLimitsForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 59,
    },

    widgetsDocker.memoryUsageForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 72,
    },
    widgetsDocker.memoryUsageForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 72,
    },
  ],
}
