class Steroids
  NavigationBar: NavigationBar
  Layer: Layer
  Tab: Tab

  navigationBar: new NavigationBar # current layer navigation bar

  constructor: ->
    @debug "Steroids loaded"

  debugBoolean: false

  debug: (msg)->
    console.log msg if @debugBoolean

  #dummy apiCall until real implementation in place
  apiCall: (something)->
    console.log something