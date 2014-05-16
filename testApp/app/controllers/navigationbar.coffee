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
      onSuccess: -> notification "hidden with animation"
      onFailure: -> alert "failed to hide"
    }

  @testShowAnimated: ->
    steroids.view.navigationBar.show {
      animated: true
    }, {
      onSuccess: -> notification "shown with animation"
      onFailure: -> alert "failed to show"
    }

  @testHide: ->
    steroids.view.navigationBar.hide {},
      onSuccess: -> notification "hidden"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.view.navigationBar.show {},
      onSuccess: -> notification "showed"
      onFailure: -> alert "failed to show"

  @testShowWithTitle: ->
    steroids.view.navigationBar.show {
      title: "Any title"
    },
      onSuccess: -> notification "shown with title"
      onFailure: -> alert "failed to show with title"

  @testShowWithTitleImagePath: ->
    steroids.view.navigationBar.show {
      titleImagePath: "/icons/pill@2x.png"
    },
    onSuccess: -> notification "shown with titleImagePath"
    onFailure: -> alert "failed to show with titleImagePath"

  @testSetButtonsWithOneRightButton: ->
    button = new steroids.buttons.NavigationBarButton
    button.title = "TEST"
    button.onTap = => notification "RIGHT BUTTON TAPPED"

    steroids.view.navigationBar.setButtons {
      right: [button]
    },
      onSuccess: => notification "buttons set"
      onFailure: => alert "failed to set buttons"

  @testSetButtonsWithManyButtons: (options={override:false})->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "EKA"
    button1.onTap = => notification "EKA BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.title = "TOKA"
    button2.onTap = => notification "TOKA BUTTON TAPPED"

    button3 = new steroids.buttons.NavigationBarButton
    button3.title = "NoCB"

    button4 = new steroids.buttons.NavigationBarButton
    button4.imagePath = "/icons/pill@2x.png"
    button4.onTap = => notification "ICON BUTTON TAPPED"

    steroids.view.navigationBar.setButtons {
      overrideBackButton: options.override
      left: [button1, button2]
      right: [button3, button4]
    },
      onSuccess: => notification "many buttons set"
      onFailure: => alert "failed to set many buttons"

  @testSetButtonsWithManyButtonsWithoutBack: ->
    @testSetButtonsWithManyButtons { override: true }

  @testSetButtonsWithoutButtons: ->
    steroids.view.navigationBar.setButtons {},
      onSuccess: => notification "all buttons removed"
      onFailure: => alert "failed to remove all buttons"

  @testUpdateTitle: ->
    steroids.view.navigationBar.update {
      title: "New title"
    },
      onSuccess: -> notification "title updated"
      onFailure: -> alert "failed to update title"

  @testUpdateTitleImage: ->
    steroids.view.navigationBar.update {
      titleImagePath: "/icons/pill@2x.png"
    },
      onSuccess: -> notification "title image updated"
      onFailure: -> alert "failed to update image title"

  @testUpdateWithButtons: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "RIGHT"
    button1.onTap = => notification "RIGHT BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.imagePath = "/icons/pill@2x.png"
    button2.onTap = => notification "LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        right: [button1]
        left: [button2]
      }
    },
      onSuccess: -> notification "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testUpdateWithNoButtons: ->
    steroids.view.navigationBar.update {
      buttons: {
        right: []
        left: []
      }
    },
      onSuccess: -> notification "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testOverrideBackbuttonTrue: ->
    steroids.view.navigationBar.update {
      overrideBackButton: true
    },
      onSuccess: -> notification "nav bar buttons updated"

  @testOverrideBackbuttonFalse: ->
    steroids.view.navigationBar.update {
      overrideBackButton: false
    },
      onSuccess: -> notification "nav bar buttons updated"

  @testSetBorderBlue: ->
    steroids.view.navigationBar.update
      border: {
        size: 1
        color: '#CCCCFF'
      }

  @testSetBackButtonTitle: ->
    customBack = new steroids.buttons.NavigationBarButton
    customBack.title = "custom back"
    steroids.view.navigationBar.update {
      backButton: customBack
    }

  @testSetBackButtonImage: ->
    customBack = new steroids.buttons.NavigationBarButton
    customBack.imagePath = "/icons/pill@2x.png"
    steroids.view.navigationBar.update {
      backButton: customBack
    }

  @testUpdateButtonsWithoutBackButton: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "NEW RIGHT"
    button1.onTap = => notification "NEW RIGHT BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.imagePath = "/icons/pill@2x.png"
    button2.onTap = => notification "LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      overrideBackButton: true
      buttons: {
        right: [button1]
        left: [button2]
      }
    },
      onSuccess: -> notification "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testButtonWithImageAsOriginal: ->
    btoImgOriginal = new steroids.buttons.NavigationBarButton
    btoImgOriginal.imagePath = "/icons/apple_colorfull.png"
    btoImgOriginal.imageAsOriginal = "true"
    btoImgOriginal.onTap = => notification "BUTTON WITH ORIGINAL IMAGE TAPPED"

    btoTintedImg = new steroids.buttons.NavigationBarButton
    btoTintedImg.imagePath = "/icons/apple_colorfull.png"
    # btoTintedImg.imageAsOriginal = "true"
    btoTintedImg.onTap = => notification "BUTTON WITH TINTED IMAGE TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        right: [btoImgOriginal]
        left: [btoTintedImg]
      }
    },
      onSuccess: -> notification "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testSetAppearanceToRainbow: ->
    steroids.view.navigationBar.setAppearance {
      tintColor: '#FF0000'
      titleTextColor: '#0000FF'
      buttonTintColor: '#00FF00'
      portraitBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
      landscapeBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
    }, {
      onSuccess: -> notification "taste the rainbow"
      onFailure: -> alert "failed set nav bar appearance"
    }
