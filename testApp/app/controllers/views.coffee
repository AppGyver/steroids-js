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
