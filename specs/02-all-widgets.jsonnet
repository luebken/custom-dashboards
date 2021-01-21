local _config = (import 'config-instana.libsonnet') + (import 'config-k8s.libsonnet');
local tagFilterExpression = import 'tagFilterExpressions.libsonnet';
local metrics = import 'metrics-infrastructure.libsonnet';
local accessRules = import 'config-accessRules.libsonnet';
local widgetsDocker = import 'widgets-docker.libsonnet';
local widgetsPod = import 'widgets-pod.libsonnet';
local widgetsJvm = import 'widgets-jvm.libsonnet';
local widgetsServices = import 'widgets-services.libsonnet';

{
  accessRules: accessRules.accessRules,

  title: 'All Widgets',

  widgets: [

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

    widgetsServices.latencyForK8sNamespace {
      width: 4,
      height: 14,
      x: 8,
      y: 64,
    },
    widgetsServices.callsForK8sNamespace {
      width: 4,
      height: 14,
      x: 0,
      y: 64,
    },
    widgetsServices.errorsForK8sNamespace {
      width: 4,
      height: 14,
      x: 4,
      y: 64,
    },

    widgetsJvm.jvmHeapMemory {
      width: 4,
      height: 13,
      x: 4,
      y: 78,
    },
    widgetsJvm.jvmThreads {
      width: 4,
      height: 13,
      x: 0,
      y: 78,
    },
    widgetsJvm.jvmGC {
      width: 4,
      height: 13,
      x: 8,
      y: 78,
    },
  ],
}
