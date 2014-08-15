
default_opts = require './sw_map_options'

class SWMap
  constructor: (options) ->
        
    this.opts = default_opts
    series = this.opts.series[0]
    series.data = options.data
    series.mapData = options.mapData
    series.joinBy = options.joinBy
    
    this.opts.chart.events.drilldown = (e) =>
      this._handle_drilldown e
    
    this.opts.chart.events.drillup = (e) =>
      this._handle_drillup e
  
  attach: ($el) ->
    this.chart = $el.highcharts 'Map', this.opts
    console.log this.chart
  
  _handle_drilldown: (e) ->
    # I believe seriesOptions is set if we have already loaded the map data
    chart = e.currentTarget
    
    if !e.seriesOptions
      mapKey = 'countries/us/' + e.point.properties['hc-key'] + '-all'
      
      if !Highcharts.maps[mapKey]
        mdata_url = 'http://code.highcharts.com/mapdata/' + mapKey + '.js'
        $.getScript mdata_url
          .done =>
            this._do_drilldown chart, e.point, mapKey
          .fail =>
            alert('failed to get map data.')
        
      else
        this._do_drilldown chart, e.point, mapKey
  
  _do_drilldown: (chart, point, mapKey) ->
      data = Highcharts.geojson(Highcharts.maps[mapKey]);

      #Set a non-random bogus value
      for p, i in data
        p.value = i+1

      #Hide loading and add series
      chart.addSeriesAsDrilldown(point, {
          name: point.name,
          data: data,
          dataLabels: {
              enabled: true,
              format: '{point.name}'
          }
      });
  
  _handle_drillup: (e) ->
    console.log 'drill up'

module.exports = SWMap