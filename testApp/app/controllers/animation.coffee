# always put everything inside PhoneGap deviceready
document.addEventListener "deviceready", ->

  # Make Navigation Bar to appear with a custom title text
  steroids.navigationBar.show { title: "animation" }

animate = (transitionName) ->
  anim = new steroids.Animation {
    transition: transitionName
  }
  anim.perform()

class window.AnimationController

  @testCurlUpFast: () ->
    anim = new steroids.Animation {
      transition: "curlUp"
      duration: 0.1
    }

    anim.perform()

  @testCurlUp: () ->
    animate("curlUp")

  @testCurlDown: () ->
    animate("curlDown")

  @testFlipVerticalFromBottom: ->
    animate("flipVerticalFromBottom")

  @testFlipFromTop: ->
    animate("flipVerticalFromTop")

  @testFlipFromRight: ->
    animate("flipHorizontalFromRight")

  @testFlipFromLeft: ->
    animate("flipHorizontalFromLeft")

  @testSlideFromLeft: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
    }

    anim.perform({}, {
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })

  @testSlideFromRight: () ->
    anim = new steroids.Animation {
      transition: "slideFromRight"
    }

    anim.perform({}, {
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })

  @testSlideFromTop: () ->
     anim = new steroids.Animation {
       transition: "slideFromTop"
     }

     anim.perform({}, {
       onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
     })

  @testSlideFromBottom: () ->
    anim = new steroids.Animation {
      transition: "slideFromBottom"
    }

    anim.perform({}, {
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })

  @testDontPerformWhenOrientationNot0: () ->
    nowRotate = ->
      navigator.notification.alert "now rotate the device off from 0 and try slideFromLeft"

    steroids.screen.setAllowedRotations {
      allowedRotations: ["landscapeLeft", "landscapeRight", "portrait", "portraitUpsideDown"]
    }, {
      onSuccess: nowRotate
    }

  @testMoreCallBacks: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
    }

    anim.perform({}, {
      onSuccess: ->
      onAnimationStarted: -> navigator.notification.alert "animation started"
      onAnimationEnded: -> navigator.notification.alert "animation ended"
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })

  @testInvalidParams_01: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
      duration: "A.6"
    }

    anim.perform({}, {
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })

  @testInvalidParams_02: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
      duration: "hellow"
    }

    anim.perform({}, {
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })

  @testLongDuration: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
      duration: "3"
    }

    anim.perform({}, {
      onFailure: -> navigator.notification.alert "..and it is failing with onFailure. great success."
    })
