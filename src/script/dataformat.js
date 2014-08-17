
var maps = {
    top: 'world',
    world: {
        highmapsData: ''
        joinBy: ['iso-a2'],
        series: [
            {
                'iso-a2': US,
                value: 500,
                drilldown: 'US'
            },
            {
                'iso-a2': CA,
                value: 503
            },
            ...
        ]
    },
    
    US: {
        total: 500,
        regions: {
            OR: {
                total: 50,
                subregions: {
                    
                }
            },
            
        }
    }
    
    
}