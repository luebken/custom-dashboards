# TODO proper filter
{
  pageload:
    {
      id: 'mrfC_zAJyzENJ38Q',
      title: 'Pageload',
      width: 4,
      height: 13,
      x: 8,
      y: 0,
      type: 'chart',
      config: {
        y1: {
          formatter: 'millis.detailed',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'beaconDuration',
              timeShift: 0,
              beaconType: 'pageLoad',
              tagFilters: [
                {
                  stringValue: 'pageLoad',
                  name: 'beacon.type',
                  operator: 'EQUALS',
                },
              ],
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'onLoadTime',
              source: 'WEBSITE',
            },
          ],
        },
        y2: {
          formatter: 'millis.compact',
          renderer: 'line',
          metrics: [],
        },
        type: 'TIME_SERIES',
      },
    },
  requests:
    {
      id: '1wTIZE5acAin4Zdj',
      title: 'Website HTTP Requests',
      width: 4,
      height: 13,
      x: 0,
      y: 0,
      type: 'chart',
      config: {
        y1: {
          formatter: 'number.compact',
          renderer: 'bar',
          metrics: [
            {
              color: '',
              metric: 'beaconCount',
              timeShift: 0,
              beaconType: 'httpRequest',
              tagFilters: [
                {
                  stringValue: 'Cart',
                  name: 'beacon.page.name',
                  entity: 'NOT_APPLICABLE',
                  operator: 'EQUALS',
                },
                {
                  stringValue: 'httpRequest',
                  name: 'beacon.type',
                  operator: 'EQUALS',
                },
              ],
              compareToTimeShifted: false,
              aggregation: 'SUM',
              label: 'Calls',
              source: 'WEBSITE',
            },
            {
              color: 'red',
              metric: 'beaconErrorCount',
              timeShift: 0,
              beaconType: 'httpRequest',
              tagFilters: [
                {
                  stringValue: 'Cart',
                  name: 'beacon.page.name',
                  entity: 'NOT_APPLICABLE',
                  operator: 'EQUALS',
                },
                {
                  stringValue: 'httpRequest',
                  name: 'beacon.type',
                  operator: 'EQUALS',
                },
              ],
              compareToTimeShifted: false,
              aggregation: 'SUM',
              label: 'Erroneous Calls',
              source: 'WEBSITE',
            },
          ],
        },
        y2: {
          formatter: 'millis.compact',
          renderer: 'line',
          metrics: [
            {
              color: '',
              metric: 'beaconDuration',
              timeShift: 0,
              beaconType: 'httpRequest',
              tagFilters: [
                {
                  stringValue: 'Cart',
                  name: 'beacon.page.name',
                  entity: 'NOT_APPLICABLE',
                  operator: 'EQUALS',
                },
                {
                  stringValue: 'httpRequest',
                  name: 'beacon.type',
                  operator: 'EQUALS',
                },
              ],
              compareToTimeShifted: false,
              aggregation: 'MEAN',
              label: 'Retrieval Time',
              source: 'WEBSITE',
            },
          ],
        },
        type: 'TIME_SERIES',
      },
    },

  javascript:
    {
      id: 'IP_U6P8uazUlr5VU',
      title: 'JavaScript',
      width: 4,
      height: 13,
      x: 4,
      y: 0,
      type: 'chart',
      config: {
        y1: {
          formatter: 'number.compact',
          renderer: 'bar',
          metrics: [
            {
              color: 'red',
              metric: 'beaconCount',
              timeShift: 0,
              beaconType: 'error',
              tagFilters: [
                {
                  stringValue: 'error',
                  name: 'beacon.type',
                  operator: 'EQUALS',
                },
              ],
              compareToTimeShifted: false,
              aggregation: 'SUM',
              label: 'Errors',
              source: 'WEBSITE',
            },
          ],
        },
        y2: {
          formatter: 'millis.compact',
          renderer: 'line',
          metrics: [],
        },
        type: 'TIME_SERIES',
      },
    },
}
