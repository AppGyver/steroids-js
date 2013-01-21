document.addEventListener "deviceready", ->

  fetchElement = document.getElementById("fetch")

  if fetchElement?
    fetchElement.addEventListener "touchstart", ->
      request = new Steroids.XHR

      # tämä kuten XHR:ssa tehtäis
      request.location = "https://registry.npmjs.org/grunt-replace"
      request.headers["jotain"] = "test"
      targetOnDisk = "/npm.json"

      request.fetch(targetOnDisk)

  Steroids.navigationBar.show { title: "DATA" }
