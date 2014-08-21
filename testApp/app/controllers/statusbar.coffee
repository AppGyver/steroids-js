class window.StatusbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "statusbar" }

  @testHide: ->
    steroids.statusBar.hide {},
      onSuccess: -> console.log "hided"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.statusBar.show {},
      onSuccess: -> console.log "showed"
      onFailure: -> alert "failed to show"

  @testShowLight: ->
    steroids.statusBar.show "light",
      onSuccess: -> console.log "showed light"
      onFailure: -> alert "failed to show light"

  @testOnTap: ->
    steroids.statusBar.onTap -> alert "status bar tapped !",
      onSuccess: -> alert "on tap event setup!"

  @testHideNavBarAnimated: ->
    steroids.view.navigationBar.hide {
      animated: true
    }, {
      onSuccess: -> alert "hided with animation"
      onFailure: -> alert "failed to hide"
    }

  @testShowNavBarAnimated: ->
    steroids.view.navigationBar.show {
      animated: true
    }, {
      onSuccess: -> alert "showed with animation"
      onFailure: -> alert "failed to show"
    }