class window.InitviewController

  @testTest: ->
    alert "test test"

  @testDismissInitialView: ->
    console.log "@testDismissInitialView called"
    myAnimation = new steroids.Animation
      transition: "curlUp"
      duration: 1.0
      curve: "easeInOut"

    steroids.initialView.dismiss
      animation: myAnimation
    ,
      onSuccess: (result) ->
        console.log "initialView.dismiss onSuccess"
      onFailure: (result) ->
        console.log "initialView.dismiss onFailure"

  @testResetAppToInitialView: ->
    console.log "@testResetAppToInitialView called"
    myAnimation = new steroids.Animation
      transition: "slideFromBottom"
      duration: 1.0
      curve: "easeInOut"

    steroids.initialView.show
      animation: myAnimation
    ,
      onSuccess: (result) ->
        console.log "initialView.show onSuccess"
      onFailure: (result) ->
        console.log "initialView.show onFailure"
