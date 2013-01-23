document.addEventListener "deviceready", ->

  Steroids.navigationBar.show { title: "DATA" }

  xhrElement = document.getElementById("xhr")

  if xhrElement?
    xhrElement.addEventListener "touchstart", ->
      Steroids.layers.push layer: new Steroids.Layer(location: "views/xhr/index.html")

  oauthElement = document.getElementById("oauth")

  if oauthElement?
    oauthElement.addEventListener "touchstart", ->
      Steroids.layers.push layer: new Steroids.Layer(location: "views/oauth/index.html")

  touchdbElement = document.getElementById("touchdb")

  if touchdbElement?
    touchdbElement.addEventListener "touchstart", ->
      Steroids.layers.push layer: new Steroids.Layer(location: "views/touchdb/index.html")
