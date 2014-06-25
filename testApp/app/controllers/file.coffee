class window.FileController
  @createFile: (options="test.png")->
    new steroids.File(options)

  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.navigationBar.show { title: "file" }


  @testResize: ->
    @createFile("test.zip").unzip "resizetest",
      onSuccess: =>
        @createFile( path: "resizetest/success.png", relativeTo: steroids.app.userFilesPath ).resizeImage {
          format:
            type: "jpg"
            compression: 100
          constraint:
            dimension: "width"
            length: 100
        },
          onSuccess: (params)=>
            img = document.createElement 'img'
            img.setAttribute 'src', "/resizetest/success.png"
            fileResult.innerHTML = ""
            fileResult.appendChild img
            steroids.logger.log "SUCCESS in resizing image"
          onFailure: =>
            steroids.logger.log "FAILURE in testResize image"

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
    @createFile("test.zip").unzip "unzippedtest",
      onSuccess: (params)=>
        img = document.createElement 'img'
        img.setAttribute 'src', "/unzippedtest/success.png"
        fileResult.innerHTML = ""
        fileResult.appendChild img
        steroids.logger.log "SUCCESS in unzipping image"
      onFailure: =>
        steroids.logger.log "FAILURE in testUnzip"
