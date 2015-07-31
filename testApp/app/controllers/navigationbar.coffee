class window.NavigationbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->
      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "navbar" }

  @testPushThisView: ->
    steroids.layers.push
      view: new steroids.views.WebView
        location: "/views/navigationbar/index.html"

  @testSetStyleId_navBarBig: ->
    steroids.view.navigationBar.setStyleId "navBarBig"
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleId"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleId"
    }

  @testSetStyleId_navBarSmall: ->
    steroids.view.navigationBar.setStyleId "navBarSmall"
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleId"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleId"
    }

  @testRemoveStyleId: ->
    steroids.view.navigationBar.setStyleId ""
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleId"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleId"
    }

  @testSetStyleCSS: ->
    steroids.view.navigationBar.setStyleCSS "background-color: pink;"
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleCSS"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleCSS"
    }

  @testRemoveStyleCSS: ->
    steroids.view.navigationBar.setStyleCSS ""
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleCSS"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleCSS"
    }

  @testAddStyleClass: ->
    steroids.view.navigationBar.addStyleClass "navBarWithBorder"
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testAddStyleClass"
      onFailure: -> navigator.notification.alert "FAILURE in testAddStyleClass"
    }

  @testSetStyleClass: ->
    steroids.view.navigationBar.setStyleClass "greenNavBar"
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in tesSetStyleClass"
      onFailure: -> navigator.notification.alert "FAILURE in tesSetStyleClass"
    }

  @testSetNewStyleClass: ->
    steroids.view.navigationBar.setStyleClass "navBarWithBorder"
    , {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetNewStyleClass"
      onFailure: -> navigator.notification.alert "FAILURE in testSetNewStyleClass"
    }

  @testHideAnimated: ->
    steroids.view.navigationBar.hide {
      animated: true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in hiding navigationBar with animation"
      onFailure: -> navigator.notification.alert "FAILURE in testHideAnimated - hiding navigationBar with animation"
    }

  @testShowAnimated: ->
    steroids.view.navigationBar.show {
      animated: true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in showing nav bar with animation"
      onFailure: -> navigator.notification.alert "FAILURE in testShowAnimated"
    }

  @testHide: ->
    steroids.view.navigationBar.hide {},
      onSuccess: -> steroids.logger.log "SUCCESS in hiding navigation bar without animation"
      onFailure: -> navigator.notification.alert "FAILURE in testHide - hiding navigation bar without animation"

  @testShow: ->
    steroids.view.navigationBar.show {},
      onSuccess: -> steroids.logger.log "SUCCESS in showing navigation bar without animation"
      onFailure: -> navigator.notification.alert "FAILURE in testShow"

  @testShowWithTitle: ->
    steroids.view.navigationBar.show {
      title: "Any title"
    },
      onSuccess: -> steroids.logger.log "SUCCESS in showing navigation bar with title"
      onFailure: -> navigator.notification.alert "FAILURE in testShowWithTitle nav bar"

  @testShowWithTitleImagePath: ->
    steroids.view.navigationBar.show {
      titleImagePath: "/icons/pill@2x.png"
    },
    onSuccess: -> steroids.logger.log "SUCCESS in showing nav bar with titleImagePath"
    onFailure: -> navigator.notification.alert "FAILURE in testShowWithTitleImagePath"

  @testSetButtonsWithManyButtons: (options={override:false})->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "EKA"
    button1.onTap = => navigator.notification.alert "EKA BUTTON TAPPED"
    button1.styleClass = "rounded-button primary"

    button2 = new steroids.buttons.NavigationBarButton
    button2.title = "TOKA"
    button2.onTap = => navigator.notification.alert "TOKA BUTTON TAPPED"
    button2.styleId = "tokaButton"

    button3 = new steroids.buttons.NavigationBarButton
    button3.title = "NoCB"
    button3.styleCSS = "border: 1px solid #FF6363;"

    button4 = new steroids.buttons.NavigationBarButton
    button4.imagePath = "/icons/pill@2x.png"
    button4.onTap = => navigator.notification.alert "ICON BUTTON TAPPED"

    steroids.view.navigationBar.update {
      overrideBackButton: options.override
      buttons:
        left: [button1, button2]
        right: [button3, button4]
    },
      onSuccess: => steroids.logger.log "SUCCESS in setting many buttons with update"
      onFailure: => navigator.notification.alert "FAILURE in testSetButtonsWithManyButtons with or without back button"


  @testSetButtonsWithDefaultStyle: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "NEWNEW LEFT"
    button1.onTap = => navigator.notification.alert "NEW RIGHT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        left: [button1]
      }
    }

  @testUpdateTitle: ->
    steroids.view.navigationBar.update {
      title: "New title"
    },
      onSuccess: -> steroids.logger.log "SUCCESS in updating navigationBar title"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdateTitle"

  @testUpdateTitleImage: ->
    steroids.view.navigationBar.update {
      titleImagePath: "/icons/pill@2x.png"
    },
      onSuccess: -> steroids.logger.log "SUCCESS in nav bar testUpdateTitleImage"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdateTitleImage"

  @testUpdateWithButtons: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "RIGHT"
    button1.onTap = => navigator.notification.alert "RIGHT BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.imagePath = "/icons/pill@2x.png"
    button2.onTap = => navigator.notification.alert "LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        right: [button1]
        left: [button2]
      }
    },
      onSuccess: -> steroids.logger.log "SUCCESS in updating buttons"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdateWithButtons"

  @testUpdateWithNoButtons: ->
    steroids.view.navigationBar.update {
      buttons: {
        right: []
        left: []
      }
    },
      onSuccess: -> steroids.logger.log "SUCCESS in updating nav bar to have no buttons"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdateWithNoButtons"

  @testOverrideBackbuttonTrue: ->
    steroids.view.navigationBar.update {
      overrideBackButton: true
    },
      onSuccess: -> steroids.logger.log "SUCCESS in overriding nav bar back button with update"
      onFailure: -> navigator.notification.alert "FAILURE in testOverrideBackbuttonTrue"

  @testOverrideBackbuttonFalse: ->
    steroids.view.navigationBar.update {
      overrideBackButton: false
    },
      onSuccess: -> steroids.logger.log "SUCCESS in dis-overriding nav bar button (a.k.a. showing it) with update"
      onFailure: -> navigator.notification.alert "FAILURE in testOverrideBackbuttonFalse"

  @testSetBorderBlue: ->
    steroids.view.navigationBar.update {
      border: {
        size: 1
        color: '#CCCCFF'
      }
    },
      onSuccess: -> steroids.logger.log "SUCCESS in setting nav bar border to blue"
      onFailure: -> navigator.notification.alert "FAILURE in testSetBorderBlue"


  @testSetBackButtonTitle: ->
    customBack = new steroids.buttons.NavigationBarButton
    customBack.title = "custom back"
    steroids.view.navigationBar.update {
      backButton: customBack
    },
      onSuccess: -> steroids.logger.log "SUCCESS in testSetBackButtonTitle"
      onFailure: -> navigator.notification.alert "FAILURE in testSetBackButtonTitle"

  @testSetBackButtonImage: ->
    customBack = new steroids.buttons.NavigationBarButton
    customBack.imagePath = "/icons/pill@2x.png"
    steroids.view.navigationBar.update {
      backButton: customBack
    },
      onSuccess: -> steroids.logger.log "SUCCESS in testSetBackButtonImage"
      onFailure: -> navigator.notification.alert "FAILURE in testSetBackButtonImage"

  @testUpdateOnlyRightButtons: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "New Right"
    button1.onTap = => navigator.notification.alert "NEW RIGHT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        right: [button1]
      }
    }

  @testUpdateOnlyOneOfTheButtons: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "NEWNEW LEFT"
    button1.onTap = => navigator.notification.alert "NEW LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        left: [button1]
      }
    }

  @testUpdateButtonsWithoutBackButton: ->
    button1 = new steroids.buttons.NavigationBarButton
    button1.title = "NEW RIGHT"
    button1.onTap = => navigator.notification.alert "NEW RIGHT BUTTON TAPPED"

    button2 = new steroids.buttons.NavigationBarButton
    button2.imagePath = "/icons/pill@2x.png"
    button2.onTap = => navigator.notification.alert "LEFT BUTTON TAPPED"

    steroids.view.navigationBar.update {
      overrideBackButton: true
      buttons: {
        right: [button1]
        left: [button2]
      }
    },
      onSuccess: -> steroids.logger.log "SUCCESS in updating buttons into nav bar but no back button"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdateButtonsWithoutBackButton"

  @testButtonWithImageAsOriginal: ->
    btoImgOriginal = new steroids.buttons.NavigationBarButton
    btoImgOriginal.imagePath = "/icons/apple_colorfull.png"
    btoImgOriginal.imageAsOriginal = "true"
    btoImgOriginal.onTap = => navigator.notification.alert "BUTTON WITH ORIGINAL IMAGE TAPPED"

    btoTintedImg = new steroids.buttons.NavigationBarButton
    btoTintedImg.imagePath = "/icons/apple_colorfull.png"
    # btoTintedImg.imageAsOriginal = "true"
    btoTintedImg.onTap = => navigator.notification.alert "BUTTON WITH TINTED IMAGE TAPPED"

    steroids.view.navigationBar.update {
      buttons: {
        right: [btoImgOriginal]
        left: [btoTintedImg]
      }
    },
      onSuccess: -> steroids.logger.log "SUCCESS in testButtonWithImageAsOriginal - updating nav bar with tint and no tint buttons"
      onFailure: -> navigator.notification.alert "FAILURE in testButtonWithImageAsOriginal"

  # LEGACY setAppearance
  @testSetAppearanceToRainbow: ->
    steroids.view.navigationBar.setAppearance {
      tintColor: '#FF0000'
      titleTextColor: '#0000FF'
      buttonTintColor: '#00FF00'
      portraitBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
      landscapeBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in testSetAppearanceToRainbow - taste the rainbow!"
      onFailure: -> navigator.notification.alert "FAILURE in testSetAppearanceToRainbow in nav bar tests"
    }

  @testTapButton_0: ->
    steroids.view.navigationBar.tapButton
      index: 0
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in tapButton"
      onFailure: -> navigator.notification.alert "FAILURE in tapButton"

  @testTapButton_1: ->
    steroids.view.navigationBar.tapButton
      index: 1
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in tapButton"
      onFailure: -> navigator.notification.alert "FAILURE in tapButton"

  @testTapButton_2: ->
    steroids.view.navigationBar.tapButton
      index: 2
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in tapButton"
      onFailure: -> navigator.notification.alert "FAILURE in tapButton"

  @testTapButton_3: ->
    steroids.view.navigationBar.tapButton
      index: 3
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in tapButton"
      onFailure: -> navigator.notification.alert "FAILURE in tapButton"

  @testTapButton_4: ->
    steroids.view.navigationBar.tapButton
      index: 4
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in tapButton"
      onFailure: -> navigator.notification.alert "FAILURE in tapButton"
