local _config = (import 'config-instana.libsonnet') + (import 'config-host.libsonnet');
local metrics = import 'metrics-infrastructure.libsonnet';
local accessRules = import 'config-accessRules.libsonnet';
local widgetsContainerd = import 'widgets-containerd.libsonnet';
local widgetsPod = import 'widgets-pod.libsonnet';
local widgetsServices = import 'widgets-services.libsonnet';
local filter = import 'tagFilterExpressions.libsonnet';

{
  accessRules: accessRules.accessRules,

  title: 'Demo / Host: ' + _config.host.fqdn,

  widgets: [

    {
      id: 'WCO-4SvwiaPDdbYx',
      title: 'cpu.user',
      width: 2,
      height: 5,
      x: 0,
      y: 6,
      type: 'bigNumber',
      config: {
        formatter: 'number.detailed',
        comparisonDecreaseColor: 'greenish',
        metricConfiguration: {
          metric: 'cpu.user',
          tagFilterExpression: filter.host.fqdn,
          timeShift: 0,
          aggregation: 'MEAN',
          source: 'INFRASTRUCTURE_METRICS',
          type: 'host',
        },
        comparisonIncreaseColor: 'redish',
      },
    },
    {
      id: 't3A89799F7aNdOGn',
      title: 'CPU Usage',
      width: 4,
      height: 15,
      x: 0,
      y: 11,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'percentage.compact',
          renderer: 'line',
          min: 0,
          max: 1,
          metrics: [
            {
              color: '',
              metric: 'cpu.user',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'cpu.sys',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'cpu.wait',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'cpu.nice',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'cpu.steal',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
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
      id: 'edFxvme5lqirjcov',
      title: 'Open Files',
      width: 12,
      height: 13,
      x: 0,
      y: 65,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'number.compact',
          renderer: 'line',
          min: 0,
          metrics: [
            {
              color: '',
              metric: 'openFiles.current',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
          ],
        },
        y2: {
          formatter: 'percentage.compact',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'openFiles.used',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
          ],
        },
        type: 'TIME_SERIES',
      },
    },
    {
      id: '24SIK9WkTmQBJMpC',
      title: 'Context Switches',
      width: 4,
      height: 15,
      x: 4,
      y: 11,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'number.compact',
          renderer: 'line',
          min: 0,
          metrics: [
            {
              color: '',
              metric: 'ctxt',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
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
      id: 'zK5PQicPavuDlsJQ',
      title: 'Builtin',
      width: 12,
      height: 6,
      x: 0,
      y: 0,
      type: 'markdown',
      config: '[' + _config.instana.baseUrl + '/#/physical?q=entity.host.fqdn%3A+' + _config.host.fqdn + '](' + _config.instana.baseUrl + '/#/physical?q=entity.host.fqdn%3A+' + _config.host.fqdn + ')',
    },
    {
      id: 'VuR-yhv34DrfXGcJ',
      title: 'Memory',
      width: 12,
      height: 13,
      x: 0,
      y: 52,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'bytes.detailed',
          renderer: 'line',
          min: 0,
          metrics: [
            {
              color: '',
              metric: 'memory.swapTotal',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'memory.swapFree',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
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
      id: '07CEbnBW4wbVKJdQ',
      title: 'load.1min',
      width: 4,
      height: 5,
      x: 8,
      y: 6,
      type: 'bigNumber',
      config: {
        formatter: 'number.detailed',
        comparisonDecreaseColor: 'greenish',
        metricConfiguration: {
          metric: 'load.1min',
          tagFilterExpression: filter.host.fqdn,
          timeShift: 0,
          aggregation: 'MEAN',
          source: 'INFRASTRUCTURE_METRICS',
          type: 'host',
        },
        comparisonIncreaseColor: 'redish',
      },
    },
    {
      id: 'M1_mnncMmgEdJKR2',
      title: 'Memory',
      width: 12,
      height: 13,
      x: 0,
      y: 26,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'percentage.compact',
          renderer: 'area',
          min: 0,
          max: 1,
          metrics: [
            {
              color: '',
              metric: 'memory.used',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
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
      id: 'bhx9mNcRSbAXRFk6',
      title: 'Memory',
      width: 12,
      height: 13,
      x: 0,
      y: 39,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'bytes.detailed',
          renderer: 'line',
          min: 0,
          metrics: [
            {
              color: '',
              metric: 'memory.buffers',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'memory.cached',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'memory.available',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
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
      id: 'nr8NATjCQBQoXYdd',
      title: 'cpu.used',
      width: 2,
      height: 5,
      x: 2,
      y: 6,
      type: 'bigNumber',
      config: {
        formatter: 'number.detailed',
        comparisonDecreaseColor: 'greenish',
        metricConfiguration: {
          metric: 'cpu.used',
          tagFilterExpression: filter.host.fqdn,
          timeShift: 0,
          aggregation: 'MEAN',
          source: 'INFRASTRUCTURE_METRICS',
          type: 'host',
        },
        comparisonIncreaseColor: 'redish',
      },
    },
    {
      id: 'huge0FnlftHO08Vq',
      title: 'memory.used',
      width: 4,
      height: 5,
      x: 4,
      y: 6,
      type: 'bigNumber',
      config: {
        formatter: 'number.detailed',
        comparisonDecreaseColor: 'greenish',
        metricConfiguration: {
          metric: 'memory.used',
          tagFilterExpression: filter.host.fqdn,
          timeShift: 0,
          aggregation: 'MEAN',
          source: 'INFRASTRUCTURE_METRICS',
          type: 'host',
        },
        comparisonIncreaseColor: 'redish',
      },
    },
    {
      id: 'Eie_M1_gb8c30gNs',
      title: 'CPU Load',
      width: 4,
      height: 15,
      x: 8,
      y: 11,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'number.compact',
          renderer: 'area',
          min: 0,
          metrics: [
            {
              color: '',
              metric: 'load.1min',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
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
      id: 'HEzwJ3_FVnzeqMmq',
      title: 'TCP Activity',
      width: 12,
      height: 13,
      x: 0,
      y: 81,
      type: 'chart',
      config: {
        shareMaxAxisDomain: false,
        y1: {
          formatter: 'number.compact',
          renderer: 'line',
          min: 0,
          metrics: [
            {
              color: '',
              metric: 'tcp.established',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.opens',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.inSegs',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.outSegs',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
          ],
        },
        y2: {
          formatter: 'percentage.compact',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'tcp.establishedResets',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.resets',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.fails',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.errors',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
            {
              color: '',
              metric: 'tcp.retrans',
              tagFilterExpression: filter.host.fqdn,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: '',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'host',
            },
          ],
        },
        type: 'TIME_SERIES',
      },
    },
  ],
}
