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

  @testSlideFromLeft: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
    }

    anim.perform({}, {
      onFailure: -> alert "..and it is failing with onFailure. great success."
    })

  @testDontPerformWhenOrientationNot0: () ->
    nowRotate = ->
      alert "now rotate the device off from 0 and try slideFromLeft"
  
    steroids.view.setAllowedRotations {
      allowedRotations: [-90, 90, 0, 180]
    }, {
      onSuccess: nowRotate
    }
    
  @testMoreCallBacks: () ->
    anim = new steroids.Animation {
      transition: "slideFromLeft"
    }
    
    anim.perform({}, {
      onAnimationStarted: -> alert "animation started"
      onAnimationEnded: -> alert "animation ended"
      onFailure: -> alert "..and it is failing with onFailure. great success."
    })

