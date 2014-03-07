class MapView extends WebView

  constructor: (options={})->
    # call WebView constructor
    super options
    
    @mapType = if options.constructor.name == "String"
      options
    else
      options.mapType
    
    @region = options.region