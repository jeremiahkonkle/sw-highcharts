
SWMap = require './script/SWMap'

unemployment_us_data = require './script/stubdata/us-states-unemployment.js' 
$.each unemployment_us_data, ->
    this.code = this.code.toUpperCase()
    this.drilldown = true

unemployment_map = new SWMap
  data: unemployment_us_data,
  mapData: Highcharts.maps['countries/us/us-all'],
  joinBy: ['postal-code', 'code']


$ ->
  unemployment_map.attach($('#map'));
  


