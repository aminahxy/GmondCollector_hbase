function showGraph(object){
  chart = new Highcharts.Chart({
    chart: {
      renderTo: object.render,
      type: 'spline'
    },
    title: {
      text: object.text
    },
    xAxis: {
      type: 'datetime'
    },
    yAxis: {
      title: {
        text: ''
      },
      startOnTick: true,
      //min: 0,
      minorGridLineWidth: 1,
      gridLineWidth: 1,
      alternateGridColor: null
    },
    tooltip: {
      formatter: function() {
        return '' + Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +': '+ this.y;
      }
    },
    plotOptions: {
      spline: {
        lineWidth: 4,
        states: {
          hover: {
            lineWidth: 5
          }
        },
        marker: {
          enabled: false,
          states: {
            hover: {
              enabled: true,
              symbol: 'circle',
              radius: 5,
              lineWidth: 1
            }
          }
        }
        //,
        //pointInterval: object.interval, // one hour
        //pointStart: object.startdate 
      }
    },
    series: object.series,
    navigation: {
      menuItemStyle: {
        fontSize: '10px'
      }
    }
  });
}
