local filter = import 'tagFilterExpressions.libsonnet';
{
  memory:
    {
      id: 'e1vRuUkMKyjIjjCY',
      title: ' Process Memory',
      width: '<NEEDS TO BE SET>',
      height: '<NEEDS TO BE SET>',
      x: '<NEEDS TO BE SET>',
      y: '<NEEDS TO BE SET>',
      type: 'chart',
      config: {
        y1: {
          formatter: 'bytes.compact',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'mem.virtual',
              tagFilterExpression: filter.k8sNamespaceAndPodLabel,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'Memory',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'process',
            },
            {
              color: '',
              metric: 'mem.resident',
              tagFilterExpression: filter.k8sNamespaceAndPodLabel,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'Resident',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'process',
            },
            {
              color: '',
              metric: 'mem.share',
              tagFilterExpression: filter.k8sNamespaceAndPodLabel,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'Share',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'process',
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
  openfiles:
    {
      id: 'oOhREm3YuPDxZTgp',
      title: 'Process Open Files',
      width: '<NEEDS TO BE SET>',
      height: '<NEEDS TO BE SET>',
      x: '<NEEDS TO BE SET>',
      y: '<NEEDS TO BE SET>',
      type: 'chart',
      config: {
        y1: {
          formatter: 'number.compact',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'openFiles.current',
              tagFilterExpression: filter.k8sNamespaceAndPodLabel,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'Current',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'process',
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
  cpu:
    {
      id: 'ItxLhtiZFRM4Fh7-',
      title: 'Process CPU Usage',
      width: '<NEEDS TO BE SET>',
      height: '<NEEDS TO BE SET>',
      x: '<NEEDS TO BE SET>',
      y: '<NEEDS TO BE SET>',
      type: 'chart',
      config: {
        y1: {
          formatter: 'percentage.detailed',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'cpu.user',
              tagFilterExpression: filter.k8sNamespaceAndPodLabel,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'User',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'process',
            },
            {
              color: '',
              metric: 'cpu.sys',
              tagFilterExpression: filter.k8sNamespaceAndPodLabel,
              timeShift: 0,
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'System',
              source: 'INFRASTRUCTURE_METRICS',
              type: 'process',
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
