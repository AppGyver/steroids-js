document.addEventListener "deviceready", ->
  document.getElementById("authenticate").addEventListener "touchstart", ->
    oauth = new Steroids.OAuth { location: "http://www.facebook.com" }
    oauth.authenticate()