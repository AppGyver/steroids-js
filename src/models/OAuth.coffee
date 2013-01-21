class OAuth

  constructor: (@options)->

  authenticate: ()=>
    authenticationLayer = new Steroids.Layer { location: @options.location }
    Steroids.modal.show({ layer: authenticationLayer })
