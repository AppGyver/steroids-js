class window.NavigationbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->
      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "navbar" }
      
  @testHideAnimated: ->
    steroids.view.navigationBar.hide {
      animated: true
    }, {
      onSuccess: -> alert "hided with animation"
      onFailure: -> alert "failed to hide"
    }

  @testShowAnimated: ->
    steroids.view.navigationBar.show {
      animated: true
    }, {
      onSuccess: -> alert "showed with animation"
      onFailure: -> alert "failed to show"
    }

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

  @testSetButtonsWithManyButtons: (options={override:false})->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "EKA"
    button1.onTap = => alert "EKA BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.title = "TOKA"
    button2.onTap = => alert "TOKA BUTTON TAPPED"

    button3 = new steroids.buttons.NavigationBarButton
    button3.title = "NoCB"

    button4 = new steroids.buttons.NavigationBarButton
    button4.imagePath = "/icons/pill@2x.png"
    button4.onTap = => alert "ICON BUTTON TAPPED"

    steroids.view.navigationBar.setButtons {
      overrideBackButton: options.override
      left: [button1, button2]
      right: [button3, button4]
    },
      onSuccess: => alert "many buttons set"
      onFailure: => alert "failed to set many buttons"

  @testSetButtonsWithManyButtonsWithoutBack: ->
    @testSetButtonsWithManyButtons { override: true }

  @testSetButtonsWithoutButtons: ->
    steroids.view.navigationBar.setButtons {},
      onSuccess: => alert "all buttons removed"
      onFailure: => alert "failed to remove all buttons"

  @testUpdateTitle: ->
    steroids.view.navigationBar.update {
      title: "New title"
    },
      onSuccess: -> alert "title updated"
      onFailure: -> alert "failed to update title"

  @testUpdateTitleImage: ->
    steroids.view.navigationBar.update {
      titleImagePath: "/icons/pill@2x.png"
    },
      onSuccess: -> alert "title image updated"
      onFailure: -> alert "failed to update image title"

  @testUpdateWithButtons: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "RIGHT"
    button1.onTap = => alert "RIGHT BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.imagePath = "/icons/pill@2x.png"
    button2.onTap = => alert "LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        right: [button1]
        left: [button2]
      }
    },
      onSuccess: -> alert "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testUpdateWithNoButtons: ->
    steroids.view.navigationBar.update {
      buttons: {
        right: []
        left: []
      }
    },
      onSuccess: -> alert "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testOverrideBackbuttonTrue: ->
    steroids.view.navigationBar.update {
      overrideBackButton: true
    }

  @testOverrideBackbuttonFalse: ->
    steroids.view.navigationBar.update {
      overrideBackButton: false
    }
  
  @testSetBorderBlue: ->
    steroids.view.navigationBar.update
      border: {
        size: 1
        color: '#CCCCFF'
      }
  
  @testUpdateButtonsWithoutBackButton: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "NEW RIGHT"
    button1.onTap = => alert "NEW RIGHT BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.imagePath = "/icons/pill@2x.png"
    button2.onTap = => alert "LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      overrideBackButton: true
      buttons: {
        right: [button1]
        left: [button2]
      }
    },
      onSuccess: -> alert "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"
