class window.NavigationbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "navigationbar" }

  @testHide: ->
    steroids.view.navigationBar.hide {},
      onSuccess: -> alert "hided"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.view.navigationBar.show {},
      onSuccess: -> alert "showed"
      onFailure: -> alert "failed to show"

  @testShowWithTitle: ->
    steroids.view.navigationBar.show {
      title: "Any title"
    },
      onSuccess: -> alert "showed with title"
      onFailure: -> alert "failed to show with title"

  @testShowWithTitleImagePath: ->
    steroids.view.navigationBar.show {
      titleImagePath: "/icons/pill@2x.png"
    },
    onSuccess: -> alert "showed with titleImagePath"
    onFailure: -> alert "failed to show with titleImagePath"

  @testSetButtonsWithOneRightButton: ->
    button = new steroids.buttons.NavigationBarButton
    button.title = "TEST"
    button.onTap = => alert "RIGHT BUTTON TAPPED"

    steroids.view.navigationBar.setButtons {
      right: [button]
    },
      onSuccess: => alert "buttons set"
      onFailure: => alert "failed to set buttons"

  @testSetButtonsWithoutButtons: ->
    steroids.view.navigationBar.setButtons {},
      onSuccess: => alert "all buttons removed"
      onFailure: => alert "failed to remove all buttons"
