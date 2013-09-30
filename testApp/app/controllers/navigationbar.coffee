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

  @testSetButtonsWithManyButtons: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "EKA"
    button1.onTap = => alert "EKA BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.title = "Toka"
    button2.onTap = => alert "TOKA BUTTON TAPPED"

    button3 = new steroids.buttons.NavigationBarButton
    button3.title = "kOLI"
    button3.onTap = => alert "KOLI BUTTON TAPPED"

    button4 = new steroids.buttons.NavigationBarButton
    button4.title = "NeLi"
    button4.onTap = => alert "NELI BUTTON TAPPED"

    steroids.view.navigationBar.setButtons {
      left: [button1, button2]
      right: [button3, button4]
    },
      onSuccess: => alert "many buttons set"
      onFailure: => alert "failed to set many buttons"

  @testSetButtonsWithoutButtons: ->
    steroids.view.navigationBar.setButtons {},
      onSuccess: => alert "all buttons removed"
      onFailure: => alert "failed to remove all buttons"
