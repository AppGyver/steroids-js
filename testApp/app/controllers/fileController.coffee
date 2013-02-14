class window.FileController

  @createFile: (options="#{steroids.app.path}/test.png")->
    new steroids.File(options)

  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.navigationBar.show { title: "file" }


  @testResize: ->
    @createFile().resizeImage {
      format:
        type: "jpg"
        compression: 100
      constraint:
        dimension: "width"
        length: 100
    },
      onSuccess: (params)=>
        img = document.createElement 'img'
        img.setAttribute 'src', "/test.png"
        fileResult.innerHTML = ""
        fileResult.appendChild img
      onFailure: =>
        alert "resize failed"

  # @testScale: ->
  #   @createFile().scaleImage {
  #     factor: 0.5
  #     compression: 1.0
  #     format: "png"
  #   },
  #     onSuccess: (params)=>
  #       img = document.createElement 'img'
  #       img.setAttribute 'src', "/test.png"
  #       fileResult.innerHTML = ""
  #       fileResult.appendChild img
  #     onFailure: =>
  #       alert "scale failed"


  @testUnzip: ->
    @createFile("#{steroids.app.path}/test.zip").unzip {
      destinationPath: "unzippedtest"
    },
      onSuccess: (params)=>
        img = document.createElement 'img'
        img.setAttribute 'src', "/unzippedtest/success.png"
        fileResult.innerHTML = ""
        fileResult.appendChild img
      onFailure: =>
        alert "unzip failed"
