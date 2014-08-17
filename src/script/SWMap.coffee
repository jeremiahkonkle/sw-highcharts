
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
  
  _handle_drilldown: (e) ->
    chart = e.currentTarget
    
    # I believe seriesOptions is set if we have already loaded the map data
    if !e.seriesOptions
      map_key = this._map_key_from_point e.point
      
      if !Highcharts.maps[map_key]
        # Font Awesome spinner
        chart.showLoading('<i class="icon-spinner icon-spin icon-3x"></i>'); 
        
        $.getScript this._map_data_url(map_key)
          .done =>
            this._do_drilldown chart, e.point, map_key
            chart.hideLoading();
          .fail =>
            console.log('failed to get map data.')
            chart.hideLoading()
        
      else
        this._do_drilldown chart, e.point, map_key
  
  _do_drilldown: (chart, point, map_key) ->
      data = Highcharts.geojson(Highcharts.maps[map_key]);

      #Set a non-random bogus value
      for p, i in data
        p.value = i+1
        p.drilldown = this._point_can_drilldown(p)
      
      #Hide loading and add series
      chart.addSeriesAsDrilldown(point, {
          name: point.name,
          data: data,
          dataLabels: {
              enabled: true,
              format: '{point.name}'
          }
      });
  
  _map_key_from_point: (point) ->
    hc_key = point.properties['hc-key']
    parts = hc_key.split('-')
    
    if not parts.length
      return undefined
    
    country = parts[0];
    
    ans = "countries/#{country}/#{hc_key}-all"
    return ans
  
  _map_data_url: (map_key) ->
    return 'http://code.highcharts.com/mapdata/' + map_key + '.js'
  
  _point_can_drilldown: (point) ->
    hc_key = point.properties['hc-key']
    parts = hc_key.split('-')
    
    if not parts.length
      # invalid key
      return false
    
    if parts.length == 1
      # assume all country level keys can drill
      return true
    
    if parts.length == 2 && parts[0] == 'us'
      # all US states can drill
      return true
    
    return false
  
  _handle_drillup: (e) ->
    console.log 'drill up'

module.exports = SWMap