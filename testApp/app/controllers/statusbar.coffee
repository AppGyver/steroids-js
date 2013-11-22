class window.StatusbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "statusbar" }

  @testHide: ->
    steroids.statusBar.hide {},
      onSuccess: -> alert "hided"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.statusBar.show {},
      onSuccess: -> alert "showed"
      onFailure: -> alert "failed to show"

  @testShowLight: ->
    steroids.statusBar.show "light",
      onSuccess: -> alert "showed light"
      onFailure: -> alert "failed to show light"
      
