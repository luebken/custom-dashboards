local _config = (import 'config-instana.libsonnet') + (import 'config-k8s.libsonnet');
local metrics = import 'metrics-infrastructure.libsonnet';
local filter = import 'tagFilterExpressions.libsonnet';

{
  pieForK8sNamespace: {
    id: 'mdoWPh7HEO1g-7Sz',
    title: 'Open Robot-Shop Events',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'pie',
    config: {
      y1: {
        formatter: 'number.detailed',
        renderer: 'pie',
        metrics: [
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:incident',
            color: 'red',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Incident',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:issue event.type:critical',
            color: 'pink',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Critical Issues',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:issue event.type:warning',
            color: '',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Warning Issues',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:change ',
            color: 'cyan',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Change',
            source: 'EVENT',
          },
        ],
      },
      y2: {
        formatter: 'number.detailed',
        renderer: 'line',
        metrics: [],
      },
    },
  },

  linksForK8sNamespace: {
    id: 'kULSSsQ7Y9ZygCLy',
    title: 'Robot-Shop:',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'markdown',
    config: '[• Incidents](' + _config.instana.baseUrl + '/#/events;view=incident?q=entity.kubernetes.namespace%3Arobot-shop)\n-\n'
            + '[• Issues](' + _config.instana.baseUrl + '/#/events;view=issue?q=entity.kubernetes.namespace%3Arobot-shop)\n-\n'
            + '[• Changes](' + _config.instana.baseUrl + '/#/events;view=change?q=entity.kubernetes.namespace%3Arobot-shop)\n-',
  },

  timeseriesForK8sNamespace: {
    id: 'VDfJVcrkI6g62EzD',
    title: 'Open Robot-Shop Events',
    width: '<NEEDS TO BE SET>',
    height: '<NEEDS TO BE SET>',
    x: '<NEEDS TO BE SET>',
    y: '<NEEDS TO BE SET>',
    type: 'chart',
    config: {
      y1: {
        formatter: 'number.compact',
        renderer: 'bar',
        metrics: [
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open ',
            color: '',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'All',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:incident',
            color: 'red',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Incidents',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:issue event.type:critical',
            color: 'pink',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Issues Critical',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:issue event.type:warning',
            color: 'orange',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Issues Warning',
            source: 'EVENT',
          },
          {
            dynamicFocusQuery: filter.k8sNamespace.dfq + ' event.state:open event.type:change ',
            color: 'cyan',
            metric: 'eventCount',
            timeShift: 0,
            compareToTimeShifted: false,
            aggregation: 'DISTINCT_COUNT',
            label: 'Change',
            source: 'EVENT',
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
