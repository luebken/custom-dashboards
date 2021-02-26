local _config = (import 'config-instana.libsonnet') + (import 'config-k8s.libsonnet');
local metrics = import 'metrics-infrastructure.libsonnet';
local accessRules = import 'config-accessRules.libsonnet';
local widgetsDocker = import 'widgets-docker.libsonnet';
local widgetsPod = import 'widgets-pod.libsonnet';

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
              + ' The original definition of the dashboard can be found [here](https://github.com/luebken/custom-dashboards/blob/master/specs/01-k8s-podlabel.libsonnet)\n\n'
              + 'Links:\n[Hosts Map](' + _config.instana.baseUrl + '/#/physical?q=entity.kubernetes.namespace%3A' + _config.k8s.ns + ') - [Container Map](' + _config.instana.baseUrl + '/#/container?q=entity.kubernetes.namespace%3A' + _config.k8s.ns + ') – [Analyze Calls](' + _config.instana.baseUrl + '/#/analyze;callList.dataSource=calls;callList.groupBy=(name~kubernetes.service.name~entity~DESTINATION)~;callList.tagFilter=!(name~kubernetes.namespace~value~' + _config.k8s.ns + '~operator~EQUALS~entity~DESTINATION)~;callList.showGraph=true;ua2=false)\n---',
    },

    widgetsDocker.cpuTotalUsageForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 6,
    },
    widgetsDocker.cpuTotalUsageForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 6,
    },

    widgetsPod.cpuRequestsAndLimitsForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 19,
    },
    widgetsPod.cpuRequestsForK8sPodLabels {
      width: 6,
      height: 13,
      x: 6,
      y: 19,
    },

    widgetsDocker.cpuThrottlingCountForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 32,
    },
    widgetsDocker.cpuThrottlingCountForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 32,
    },

    widgetsPod.memoryRequestsAndLimitsForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 45,
    },
    widgetsPod.memoryRequestsAndLimitsForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 45,
    },

    widgetsDocker.memoryUsageForK8sNamespace {
      width: 6,
      height: 13,
      x: 0,
      y: 59,
    },
    widgetsDocker.memoryUsageForK8sPodLabel {
      width: 6,
      height: 13,
      x: 6,
      y: 59,
    },
  ],
}
