class window.DataController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "data" }

  @testTouchDBEstablishConnection: ->
    alert("establish conn")

  @testRSSFetch: ->
    alert("fetch")