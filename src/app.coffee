
SWMap = require './script/SWMap'

# unemployment_us_data = require './script/stubdata/us-states-unemployment.js'
# $.each unemployment_us_data, ->
#     this.code = this.code.toUpperCase()
#     this.drilldown = true

data = Highcharts.geojson(Highcharts.maps['custom/world']);

#Set a non-random bogus value
for p, i in data
  p.value = i+1
  p.drilldown = true

unemployment_map = new SWMap
  data: data

$ ->
  unemployment_map.attach($('#map'));
  


