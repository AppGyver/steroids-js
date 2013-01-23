document.addEventListener "deviceready", ->

  Steroids.navigationBar.show { title: "XHR" }

  fetchElement = document.getElementById("fetch")

  if fetchElement?
    fetchElement.addEventListener "touchstart", ->

      request = new Steroids.XHR
      request.open("GET", "http://www.google.com")
      request.fetch({filename: "google.html"})


  showFetchedElement = document.getElementById("showFetched")

  if showFetchedElement?
    showFetchedElement.addEventListener "touchstart", ->
      fetchedLayer = new Steroids.Layer location: "../../google.html"
      Steroids.layers.push(layer: fetchedLayer)
