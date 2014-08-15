module.exports =
  chart:
      borderWidth: 0,
      borderColor: '#759F00',
      events:
        drilldown: null,
        drillup: null

  title:
      text : 'Waiverites'

  legend:
      layout: 'vertical',
      borderWidth: 0,
      backgroundColor: 'rgba(255,255,255,0.85)',
      floating: false,
      verticalAlign: 'middle',
      align: 'left',
      y: 50,
      

  mapNavigation:
      enabled: true

  colorAxis:
      min: 1,
      type: 'logarithmic',
      # minColor: '#EEEEFF',
      # maxColor: '#000022',
      # stops: [
      #     [0, '#EFEFFF'],
      #     [0.67, '#4444FF'],
      #     [1, '#000022']
      # ]

      minColor: '#FFFFFF',
      maxColor: '#759F00',
      # stops: [
      #     [0, '#EFEFFF'],
      #     [0.67, '#4444FF'],
      #     [1, '#000022']
      # ]
      
      # SW Green #759F00

  series: [
      animation: {
          duration: 1000
      },
      data: null,
      mapData: null,
      joinBy: null,
      dataLabels: {
          enabled: true,
          color: 'white',
          format: '{point.code}'
      },
      name: 'US',
      tooltip: {
          pointFormat: '{point.code}: {point.value}/km²'
      }
  ]
  
  drilldown:
      #series: drilldownSeries,
      activeDataLabelStyle:
          color: 'white',
          textDecoration: 'none'
      
      drillUpButton:
        relativeTo: 'spacingBox',        
        position:
          x: 0,
          y: 0
          
          # position:
          #     x: 0,
          #     y: 60
