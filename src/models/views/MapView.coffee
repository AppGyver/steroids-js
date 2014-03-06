class MapView

  constructor: (options={})->
    @mapType = if options.constructor.name == "String"
      options
    else
      options.mapType

    @region = options.region
