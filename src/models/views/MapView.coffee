class MapView extends WebView

  constructor: (options={})->
    # call WebView constructor
    super options
    
    @mapType = if options.constructor.name == "String"
      options
    else
      options.mapType
    
    @region = options.region
    
  addMarkers: (options={}, callbacks={}) ->
    # markers -> array of markers
    markers = if options.constructor.name == "Array"
      options
    else
      options.markers
      
    steroids.nativeBridge.nativeCall
      method: "addMarkersToMap"
      parameters:
        id: @id
        markers: markers
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]