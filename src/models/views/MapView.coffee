class MapView extends WebView

  constructor: (options={})->
    if not options.location?
      options.location = "map_empty_overlay.html"

    # call WebView constructor
    super options

    @mapType = if options.constructor.name == "String"
      options
    else
      options.mapType

    @showsUserLocation = options.showsUserLocation

    @region = options.region

  getMapParameters: () ->
    {
      mapType: @mapType
      showsUserLocation: @showsUserLocation
      region: @region
    }

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
