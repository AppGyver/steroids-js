class window.EventsController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->
  	#register for the custom events
  	document.addEventListener "layerwillchange", (event)->
  		detail = event.detail
  		alert "Event: layerwillchange sourceWebView: #{detail.sourceWebView} targetWebView: #{detail.targetWebView}"

  	document.addEventListener "layerdidchange", (event)->
  		detail = event.detail
  		alert "Event: layerdidchange sourceWebView: #{detail.sourceWebView} targetWebView: #{detail.targetWebView}"

  	document.addEventListener "tabwillchange", (event)->
  		detail = event.detail
  		alert "Event: tabwillchange sourceTabTitle: #{detail.sourceTabTitle} targetTabTitle: #{detail.targetTabTitle}"

  	document.addEventListener "tabdidchange", (event)->
  		detail = event.detail
  		alert "Event: tabdidchange sourceTabTitle: #{detail.sourceTabTitle} targetTabTitle: #{detail.targetTabTitle}"

  @testSteroidsReady: () ->
    steroids.on "ready", () ->
      alert "I was called inside steroids ready"

  @testDeviceReady: () ->
    document.addEventListener "deviceready", ->
      alert "I was called inside deviceready"