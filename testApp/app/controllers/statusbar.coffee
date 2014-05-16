class window.StatusbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "statusbar" }

  @testHide: ->
    steroids.statusBar.hide {},
      onSuccess: -> notification "hidden"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.statusBar.show {},
      onSuccess: -> notification "shown"
      onFailure: -> alert "failed to show"

  @testShowLight: ->
    steroids.statusBar.show "light",
      onSuccess: -> notification "shown light"
      onFailure: -> alert "failed to show light"
  
  @testOnTap: ->
    steroids.statusBar.onTap -> notification "status bar tapped !",
      onSuccess: -> alert "on tap event setup!"
