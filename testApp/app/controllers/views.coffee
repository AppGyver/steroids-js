class window.ViewsController

  document.addEventListener "DOMContentLoaded", ->

    if document.querySelector("#parameterlist")
      # params.html
      if steroids.view.params?
        for key, value of steroids.view.params
          li = document.createElement "li"
          li.innerHTML = "#{key}: #{value}"
          document.querySelector("#parameterlist").appendChild(li)
    else
      # index.html

      for el in document.querySelectorAll(".openViewWithParameters")
        el.addEventListener "touchend", ->

          url = this.getAttribute("data-url")

          view = new steroids.views.WebView
            location: url
            parameters: {
              kissa: "koira"
              lol_wat: "o m g"
              "param with spaces": "tesla"
            }
          steroids.layers.push(view)


  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    onresizeCounter = 0

    displayInnerSizes = ->
      document.getElementById("innerHeight").innerHTML  = window.innerHeight
      document.getElementById("innerWidth").innerHTML   = window.innerWidth
      document.getElementById("heightBar").style.height = "#{window.innerHeight}px"

    increaseOnResizeCounter = ->
      onresizeCounter++
      document.getElementById("onresizeCounter").innerHTML = onresizeCounter

    window.onresize = ->
      displayInnerSizes()
      increaseOnResizeCounter()

    displayInnerSizes()

  @testShowNavBar: ->
    steroids.view.navigationBar.show()

  @testHideNavBar: ->
    steroids.view.navigationBar.hide()

  @testShowTabBar: ->
    steroids.tabBar.show()

  @testHideTabBar: ->
    steroids.tabBar.hide()
