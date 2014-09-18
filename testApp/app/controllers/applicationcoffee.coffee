class window.ApplicationcoffeeController

  @getPicFromUserFiles = () ->
    testPic = new Image()
    testPic.width = 250

    testPic.onload = () ->
      loadResult.innerHTML = "Test success!"
      document.querySelector('#userFilesPic').appendChild(testPic)

    testPic.onerror = (error) ->
      loadResult.innerHTML = "Test Fail: " + error

    testPic.src = steroids.app.absoluteUserFilesPath + "/test.png"