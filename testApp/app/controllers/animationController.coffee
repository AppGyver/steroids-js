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

