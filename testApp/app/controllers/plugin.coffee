class window.PluginController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "Plugin" }

    now = new Date()
    diff = now.getTime() - window.___START_TIME.getTime()

    list = document.getElementById("ready")
    el = document.createElement("li")
    el.innerHTML = now.toLocaleTimeString() + " Cordova READY - " + diff + " ms since page load"
    list.appendChild(el)

  appendToDom = (content) =>
    parent = document.getElementById("app-status-ul")
    li = document.createElement("li")
    li.innerHTML = content
    parent.appendChild li

  printNotification = (notification) =>
    # android and ios have difference payloads
    message = notification.message || notification.alert
    sound = notification.sound || notification.soundname

    appendToDom "notification .message || .alert: #{message}"
    appendToDom "notification.badge: #{notification.badge}"
    appendToDom "notification .sound || .soundname: #{sound}"
    appendToDom "notification.msgcnt: #{notification.msgcnt}"

  @testPushHandleBackGroundMessages = () =>

    errorHandler = (error) =>
      console.log "pushNotification.register error: ", error
      appendToDom "ERROR -> MSG: #{error.msg}"

    # this notifications happened while the app was in the background
    # when notification are received in the background the app might be running
    # or not running.
    backgroundNotifications = (notification) =>

      console.log "BACKGROUND Notifications : #{JSON.stringify(notification)}"

      appendToDom "BACKGROUND NOTIFICATION"

      # coldstart indicates that the application was not running
      # and it was started by the notification
      if notification.coldstart
        #ios is always true ?
        appendToDom "COLDSTART - App was started by the notification :-)"
      else
        appendToDom "RUNNIG - App received and handled the notification while running in background"

      printNotification notification

    window.plugins.pushNotification.onMessageInBackground backgroundNotifications, errorHandler

  @testPushHandleForegroundMessages = () =>
    errorHandler = (error) =>
      console.log "pushNotification.register error: ", error
      appendToDom "ERROR -> MSG: #{error.msg}"

    # this notification happened while we were in the foreground.
    # you might want to play a sound to get the user's attention, throw up a dialog, etc.
    foregroundNotifications = (notification) =>
      console.log "foregroundNotifications : #{JSON.stringify(notification)}"

      appendToDom "FOREGROUND NOTIFICATION"

      # if the notification contains a soundname, play it.
      sound = notification.sound || notification.soundname

      myMedia = new Media "#{steroids.app.absolutePath}/#{sound}"
      myMedia.play()

      printNotification notification

    # register the notification handlers
    window.plugins.pushNotification.onMessageInForeground foregroundNotifications, errorHandler

  # Push Plugin
  # Project Number: 1065347639553
  @testPushRegister = () =>

    successHandler = (token) =>
      console.log "pushNotification.register success : #{token}"
      # save the device registration/token in the server
      appendToDom "Registration Complete -> Token/DeviceID -> #{token}"

    errorHandler = (error) =>
      console.log "pushNotification.register error: ", error
      appendToDom "ERROR -> MSG: #{error}"

    window.plugins.pushNotification.register successHandler, errorHandler, {

      "senderID": "1065347639553" # android only option

      "badge": true # ios only options
      "sound": true
      "alert": true
    }
    # senderID can also be configured in the -> config.android.xml

  @testPushUnregister = () =>

    successHandler = (msg) =>
      console.log "pushNotification.unregister success : #{msg}"
      # save the device registration/token in the server
      appendToDom "Unregister complete: #{msg}"

    errorHandler = (error) =>
      console.log "pushNotification.unregister error: ", error
      appendToDom "ERROR -> MSG: #{error}"

    window.plugins.pushNotification.unregister successHandler, errorHandler

  @testBadgeReset = () =>
    successHandler = (msg) =>
      console.log "pushNotification.setApplicationIconBadgeNumber success : #{msg}"
      # save the device registration/token in the server
      appendToDom "Badges reset!"

    errorHandler = (error) =>
      console.log "pushNotification.setApplicationIconBadgeNumber error: ", error
      appendToDom "ERROR -> MSG: #{error}"

    plugins.pushNotification.setApplicationIconBadgeNumber successHandler, errorHandler, 0

  @testBadgeSet = () =>
    successHandler = (msg) =>
      console.log "pushNotification.setApplicationIconBadgeNumber success: #{msg}"
      # save the device registration/token in the server
      appendToDom "Badge set to 2!"

    errorHandler = (error) =>
      console.log "pushNotification.setApplicationIconBadgeNumber error: ", error
      appendToDom "ERROR -> MSG: #{error}"

    plugins.pushNotification.setApplicationIconBadgeNumber successHandler, errorHandler, 2


  # ACCELEROMETER TEST

  accelerometerOnSuccess = (acceleration) ->
    accel_x.innerHTML = acceleration.x;
    accel_y.innerHTML = acceleration.y;
    accel_z.innerHTML = acceleration.z;
    accel_timestamp.innerHTML = acceleration.timestamp;

  accelerometerOnError= () ->
    navigator.notification.alert 'accelerometer onError!'


  # TODO: the success callback function continues to fire forever and ever
  @accelerometerTest = () ->
    navigator.accelerometer.getCurrentAcceleration accelerometerOnSuccess, accelerometerOnError

  watchId = undefined
  @watchAccelerationTest = () ->
    options =
      frequency: 100
    watchId = navigator.accelerometer.watchAcceleration accelerometerOnSuccess, accelerometerOnError
    navigator.notification.alert "watching acceleration"

  @clearAccelerationWatchTest = () ->
    navigator.accelerometer.clearWatch watchId
    accel_x.innerHTML = "";
    accel_y.innerHTML = "";
    accel_z.innerHTML = "";
    accel_timestamp.innerHTML = "";


  # BARCODE TEST

  @barCodeScanTest = () ->
    cordova.plugins.barcodeScanner.scan (result) ->
      if result.cancelled
        navigator.notification.alert "the user cancelled the scan"
      else
        qr_result.innerHTML = result.text
    ,
    (error) ->
      navigator.notification.alert "scanning failed: " + error

  # CAMERA TEST

  cameraOnSuccess = (imageData) ->
    image = document.querySelector '#cameraTest'
    image.src = "data:image/jpeg;base64," + imageData;


  cameraOnFail = (message) ->
    navigator.notification.alert 'Failed because: ' + message


  @cameraGetPictureTest = () ->
    navigator.camera.getPicture cameraOnSuccess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL
      sourceType: Camera.PictureSourceType.CAMERA
      targetWidth: 300
      targetHeight: 300
      encodingType: Camera.EncodingType.JPEG
      mediaType: Camera.MediaType.PICTURE
      allowEdit : false
      correctOrientation: true
      saveToPhotoAlbum: false
    }

  modalOpenedSuccess = () ->
    navigator.notification.alert "modal opened on the camera callback !"

  openModalOnSucess = (imageData) ->
    image = document.querySelector '#cameraTest'
    image.src = "data:image/jpeg;base64," + imageData;
    #open a modal
    steroids.modal.show
      view: new steroids.views.WebView "/views/modal/hide.html"
    ,
      onSuccess: modalOpenedSuccess

  @cameraFromPhotoLibraryOpenModalTest = () ->
    navigator.camera.getPicture openModalOnSucess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL
      sourceType: Camera.PictureSourceType.PHOTOLIBRARY
      targetWidth: 300
      targetHeight: 300
      encodingType: Camera.EncodingType.JPEG
      mediaType: Camera.MediaType.PICTURE
      allowEdit : false
      correctOrientation: true
      saveToPhotoAlbum: false
    }

  @cameraGetPictureOpenModalTest = () ->
    navigator.camera.getPicture openModalOnSucess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL
      sourceType: Camera.PictureSourceType.CAMERA
      targetWidth: 300
      targetHeight: 300
      encodingType: Camera.EncodingType.JPEG
      mediaType: Camera.MediaType.PICTURE
      allowEdit : false
      correctOrientation: true
      saveToPhotoAlbum: false
    }

  @cameraCleanupTest = () ->
    navigator.camera.cleanup(
      () ->
        navigator.notification.alert "Camera cleanup success"
      (message) ->
        navigator.notification.alert "Camera cleanup failed: " + message
    )

  @cameraFromPhotoLibraryTest = () ->
    navigator.camera.getPicture cameraOnSuccess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL
      sourceType: Camera.PictureSourceType.PHOTOLIBRARY
      targetWidth: 300
      targetHeight: 300
      encodingType: Camera.EncodingType.JPEG
      mediaType: Camera.MediaType.PICTURE
      allowEdit : false
      correctOrientation: true
      saveToPhotoAlbum: false
    }

  fileError = (error)->
    navigator.notification.alert "Cordova error code: " + error.code, null, "File system error!"

  fileMoved = (file)->
    image = document.querySelector '#cameraTest'
    image.src = "/#{file.name}?#{(new Date()).getTime()}"

  gotFileObject = (file)->
    targetDirURI = "file://" + steroids.app.absoluteUserFilesPath
    fileName = "user_pic.png"

    window.resolveLocalFileSystemURL(
      targetDirURI
      (directory)->
        file.moveTo directory, fileName, fileMoved, fileError
      fileError
    )

  saveInUserFilesOnSuccess = (imageURI) ->
    window.resolveLocalFileSystemURL imageURI, gotFileObject, fileError

  @cameraGetPictureSaveInUserFilesTest = () ->
    navigator.camera.getPicture saveInUserFilesOnSuccess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.FILE_URI
      sourceType: Camera.PictureSourceType.CAMERA
      targetWidth: 300
      targetHeight: 300
      encodingType: Camera.EncodingType.JPEG
      mediaType: Camera.MediaType.PICTURE
      allowEdit : false
      correctOrientation: true
      saveToPhotoAlbum: false
    }

  @cameraFromPhotoLibrarySaveInUserFilesTest = () ->
    navigator.camera.getPicture saveInUserFilesOnSuccess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.FILE_URI
      sourceType: Camera.PictureSourceType.PHOTOLIBRARY
      targetWidth: 300
      targetHeight: 300
      encodingType: Camera.EncodingType.JPEG
      mediaType: Camera.MediaType.PICTURE
      allowEdit : false
      correctOrientation: true
      saveToPhotoAlbum: false
    }

  # CAPTURE TEST

  captureOnSuccess = (mediaFiles) ->
    for item in mediaFiles
      navigator.notification.alert item.fullPath

  captureOnError = (error) ->
    navigator.notification.alert 'Capture error, error code: ' + error.code


  @captureAudioTest = () ->
    navigator.device.capture.captureAudio captureOnSuccess, captureOnError, {}


  @captureImageTest = () ->
    navigator.device.capture.captureImage captureOnSuccess, captureOnError, {limit:1}


  @captureVideoTest = () ->
    navigator.device.capture.captureVideo captureOnSuccess, captureOnError, {}

  # COMPASS TEST

  compassOnSuccess = (heading) ->
    compass_result.innerHTML = heading.magneticHeading

  compassOnError = (error) ->
    navigator.notification.alert 'CompassError: ' + error.code

  @compassTest = () ->
    navigator.compass.getCurrentHeading compassOnSuccess, compassOnError

  # CONNECTION TEST

  @connectionTest = () ->
    networkState = navigator.network.connection.type;

    states = {}
    states[Connection.UNKNOWN]  = 'Unknown connection'
    states[Connection.ETHERNET] = 'Ethernet connection'
    states[Connection.WIFI]     = 'WiFi connection'
    states[Connection.CELL_2G]  = 'Cell 2G connection'
    states[Connection.CELL_3G]  = 'Cell 3G connection'
    states[Connection.CELL_4G]  = 'Cell 4G connection'
    states[Connection.NONE]     = 'No network connection'

    connection_result.innerHTML = states[networkState]

  # CONTACTS TEST

  myContact = undefined
  contactsSaveOnSuccess = (contact) ->
    contacts_result.innerHTML = contact.nickname + " created in Contacts."

  contactsSaveOnError = (contactError) ->
    contacts_result.innerHTML = "Contact save error = " + contactError.code

  @contactsSaveTest = () ->
    myContact = navigator.contacts.create {
      "displayName": "Dolan Duck"
      "nickname": "Dolan Duck"
    }
    myContact.note = "GOOBY PLZ"

    name = new ContactName()
    name.givenName = "Dolan"
    name.familyName = "Duck"
    myContact.name = name

    myContact.save contactsSaveOnSuccess, contactsSaveOnError

  # CONTACTS FIND TEST

  contactsFindOnSuccess = (contacts) ->
    contacts_result.innerHTML = 'Found ' + contacts.length + ' contacts matching Dolan.'


  contactsFindOnError = (contactError) ->
    contacts_result.innerHTML = 'Contacts find onError:' + contactError.code


  # find all contacts with 'Dolan' in any name field
  @contactsFindTest = () ->
    options = new ContactFindOptions
    options.filter = "Dolan"
    options.multiple = true
    fields = ["displayName", "name"]
    navigator.contacts.find fields, contactsFindOnSuccess, contactsFindOnError, options

  # DEVICE TESTS

  @deviceTest = () ->
    device_result.innerHTML =
      "Device model: " + device.model + "<br>" +
      "Device Cordova: " + device.cordova + "<br>" +
      "Device platform: " + device.platform + "<br>" +
      "Device UUID: " + device.uuid + "<br>" +
      "Device version: " + device.version + "<br>"

  # EVENTS TESTS

  @addPause = () ->
    document.addEventListener "pause", () ->
      if pause_result.innerHTML == "NO"
        pause_result.innerHTML = "YES: " + new Date().toLocaleTimeString();
      else
        pause_result.innerHTML += "<br>another one: " + new Date().toLocaleTimeString();

    navigator.notification.alert "Event listener added: pause"

  @addResume = () ->
    # alert needs to be wrapped in setTimeout to work
    document.addEventListener "resume", () ->
      if resume_result.innerHTML == "NO"
        resume_result.innerHTML = "YES: " + new Date().toLocaleTimeString();
      else
        resume_result.innerHTML += "<br>another one: " + new Date().toLocaleTimeString();

    navigator.notification.alert "Event listener added: resume"

  @addOnline = () ->
    document.addEventListener "online", () ->
      online_result.innerHTML = "YES"

    navigator.notification.alert "Event listener added: online"

  @addOffline = () ->
    document.addEventListener "offline", () ->
      offline_result.innerHTML = "YES"

    navigator.notification.alert "Event listener added: offline"

  @addBatteryCritical = () ->
    window.addEventListener "batterycritical", (status) ->
      navigator.notification.alert "Device's battery level is critical, with  #{status.level}
        % battery life. \n
        Is it plugged in? #{status.isPlugged}"

    navigator.notification.alert "Event listener added: batterycritical"

  @addBatteryLow = () ->
    window.addEventListener "batterylow", (status) ->
      navigator.notification.alert "Device's battery level is low, with  #{status.level}
        % battery life. \n
        Is it plugged in? #{status.isPlugged}"

    navigator.notification.alert "Event listener added: batterylow"

  @addBatteryStatus = () ->
    window.addEventListener "batterystatus", (status) ->
      navigator.notification.alert "Device's battery level was changed by at least 1%, with  #{status.level}
        % battery life. \n
        Is it plugged in? #{status.isPlugged}"

    navigator.notification.alert "Event listener added: batterystatus"

  @addBackButton = () ->

    handler = () ->
      navigator.notification.alert "Device's back button pressed !"

    document.addEventListener "backbutton", handler, false

    navigator.notification.alert "Event listener added: backbutton"

  @addMenuButton = () ->

    handler = () ->
      navigator.notification.alert "Menu button pressed !"

    document.addEventListener "menubutton", handler, false

    navigator.notification.alert "Event listener added: menubutton"

  @addSearchButton = () ->

    handler = () ->
      navigator.notification.alert "searchbutton button pressed !"

    document.addEventListener "searchbutton", handler, false

    navigator.notification.alert "Event listener added: searchbutton"

  # FILE TEST

  testFS = undefined
  @getFileSystemTest = () ->
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, gotFS, fileTestFail

  @readFileTest = () ->
    if testFS?
      testFS.root.getFile "lol.txt", {create:true}, gotFileEntry, fileTestFail
    else
      navigator.notification.alert "Request a fileSystem with the 'Get fileSystem' test first"

  @writeFileTest = () ->
    if testFS?
      testFS.root.getFile "lol.txt", {create:true}, gotFileToWrite, fileTestFail
    else
      navigator.notification.alert "Request a fileSystem with the 'Get fileSystem' test first"

  @deleteFileTest = () ->
    if testFS?
      testFS.root.getFile "lol.txt", {create:false}, gotFileToDelete, fileTestFail
    else
      navigator.notification.alert "Request a fileSystem with the 'Get fileSystem' test first"

  gotFS = (fileSystem) ->
    navigator.notification.alert "Got file system with root path: " + fileSystem.root.fullPath
    testFS = fileSystem

  gotFileEntry = (fileEntry) ->
    navigator.notification.alert "Got file entry with path: " + fileEntry.fullPath
    fileEntry.file gotFile, fileTestFail

  gotFileToWrite = (fileEntry) ->
    fileEntry.createWriter (fileWriter) ->
      fileWriter.onwriteend = (e) ->
        file_result.innerHTML = "Write completed"
      fileWriter.onerror = (e) ->
        file_result.innerHTML = 'Write failed: ' + JSON.stringify e

      # Create a new Blob and write it to log.txt.
      blob = new Blob ['Lorem Ipsum'], {type: 'text/plain'}

      fileWriter.write blob

    , fileTestFail

  gotFileToDelete = (fileEntry) ->
    fileEntry.remove( () ->
      file_result.innerHTML = "File: #{fileEntry.name} deleted from path: #{fileEntry.fullPath}"
    ,
    (error) ->
      fileTestFail
    )

  gotFile = (file) ->
    navigator.notification.alert "Got file: #{file.name} \n
          Full path: #{file.fullPath} \n
          Mime type: #{file.type} \n
          Last modified: #{file.lastModifiedDate} \n
          Size in bytes: #{file.size}"
    readDataUrl(file);
    readAsText(file);

  readDataUrl = (file) ->
    reader = new FileReader()
    reader.onloadend = (evt) ->
      navigator.notification.alert "Read as data URL: " + evt.target.result

    reader.readAsDataURL file

  readAsText = (file) ->
    reader = new FileReader()
    reader.onloadend = (evt) ->
      file_result.innerHTML = "
        Contents of #{file.name}: \n
        #{evt.target.result}"

    reader.readAsText file

  fileTestFail = (evt) ->
      navigator.notification.alert "FILETESTFAIL: " + JSON.stringify evt


  imageFileURL = undefined

  @fileURLTest = () ->
    if testFS?
      testFS.root.getFile "image.png", {create:true}, gotImage, imageTestFail
    else
      navigator.notification.alert "Request a fileSystem with the 'Get fileSystem' test first"

  @URLtoFileEntryTest = () ->
    if testFS?
      window.resolveLocalFileSystemURL imageFileURL, (fileEntry)->
        fileURL_result.innerHTML = "fileEntry.fullPath: " + fileEntry.fullPath
      , imageTestFail
    else
      navigator.notification.alert "Request a fileSystem with the 'Get fileSystem' test first"

  gotImage = (fileEntry) ->
    imageFileURL = fileEntry.toURL()
    fileURL_result.innerHTML = "fileEntry.toURl(): #{imageFileURL}"

  imageTestFail = (error) ->
    fileURL_result.innerHTML = "Error resolving fileEntry: " + JSON.stringify error

  #FILETRANSFER TEST

  readDownloadAsText = (file) ->
    reader = new FileReader()
    reader.onloadend = (evt) ->
      fileTransfer_result.innerHTML = "
        Contents of #{file.name}: \n
        #{evt.target.result}"

    reader.readAsText file

  downloadFromURL = (uri, fileName, options={}) ->
    fileTransfer = new FileTransfer()
    filePath = steroids.app.absoluteUserFilesPath + fileName
    uri = encodeURI uri
    fileTransfer.download(
      uri
      filePath
      (entry) ->
        fileTransfer_result.innerHTML = "Download complete: #{entry.fullPath}, attempting to read file (if test stalls here, not download problem)"
        win = (fileObject) ->
          readDownloadAsText fileObject
        fail = (error) ->
          fileTransfer_result.innerHTML = "Failed to read file: #{JSON.stringify error}"
        entry.file win, fail
      (error) ->
        fileTransfer_result.innerHTML = "
          download error source: #{error.source} \n
          download error target: #{error.target} \n
          download error code: #{error.code}"
      false
      options
    )

  @downloadTest = () ->
    fileTransfer_result.innerHTML = "Downloading from docs.appgyver.com/en/stable/index.html"
    downloadFromURL "http://docs.appgyver.com/en/stable/index.html", "/test.response"


  @downloadRedirectTest = () ->
    fileTransfer_result.innerHTML = "Downloading from docs.appgyver.com, should redirect to /en/stable/index.html"
    downloadFromURL "http://docs.appgyver.com", "/test.redirect.response"

  @downloadAuthTest = () ->
    fileTransfer_result.innerHTML = "Downloading with basic auth"
    downloadFromURL(
      "https://api.flowdock.com/flows/flemy/main/files/XaD24A7P0l_M__E4B1YBUw/20130624_130747.jpg"
      "test.auth.response"
      { headers: { "Authorization": "Basic NjBlMDQ1MTE5NWZhZDY4OTg5OTU5NGE4Zjg0YzNjYmE6bnVsbA==" } }
    )

  @clearDownloadResult = () ->
    fileTransfer_result.innerHTML = "result cleared"

  # GEOLOCATION TEST

  onGeolocationSuccess = (position) ->
    geoLocation_result.innerHTML = "
      Latitude: #{position.coords.latitude} \n
      Longitude: #{position.coords.longitude} \n
      Altitude: #{position.coords.altitude} \n
      Accuracy: #{position.coords.accuracy} \n
      Altitude Accuracy: #{position.coords.altitudeAccuracy} \n
      Heading: #{position.coords.heading} \n
      Speed: #{position.coords.speed} \n
      Timestamp: #{position.timestamp} \n"

  # onError Callback receives a PositionError object

  onGeolocationError = (error) ->
    navigator.notification.alert "
      code: #{error.code} \n
      message: #{error.message} "

  @geolocationTest = () ->
    navigator.geolocation.getCurrentPosition onGeolocationSuccess, onGeolocationError

  watchId = undefined

  @watchPositionTest = () ->
    watchId = navigator.geolocation.watchPosition onGeolocationSuccess, onGeolocationError

  @clearPositionWatchTest = () ->
    if watchId?
      navigator.geolocation.clearWatch(watchId)
      geoLocation_result.innerHTML = "Watch cleared"
    else
      geoLocation_result.innerHTML = "No position watch to clear"

  # GLOBALIZATION TEST

  @localeTest = () ->
    navigator.globalization.getLocaleName (locale) ->
      globalization_result.innerHTML = locale.value

  @DSTTest = () ->
    navigator.globalization.isDayLightSavingsTime(
      new Date()
      (date) ->
        globalization_result.innerHTML = "Is Daylight savings: " + date.dst
      (error) ->
        globalization_result.innerHTML = "Error: " + JSON.stringify error
    )

  # INAPPBROWSER TEST

  ref = undefined
  loadNum = 0

  exit = () ->
    ref.removeEventListener 'loadstart', loadStart
    ref.removeEventListener 'exit', exit

    if loadNum > 1
      steroids.logger.log "SUCCESS in IABRedirectTest, loadstarts: #{loadNum}"
    else
      steroids.logger.log "FAILURE in IABRedirectTest, loadstarts: #{loadNum}"

    loadNum = 0

  loadStart = (e) ->
    loadNum++

  @openIABTest = () ->
    ref = window.open 'http://www.google.com', '_blank', 'location=yes'

  @IABRedirectTest = () ->
    ref = window.open 'http://www.gooogle.com', '_blank', 'location=yes'

    ref.addEventListener('loadstart', loadStart);
    ref.addEventListener('exit', exit);

  # MEDIA TEST

  my_media = null;

  # Play audio

  @playExistingAudioFile = () ->
    some_media = new Media "http://audio.ibeat.org/content/p1rj1s/p1rj1s_-_rockGuitar.mp3"
    some_media.play()

  @playAudio = () ->
    if my_media == null
        my_media = new Media "documents://"+"lol.wav"
        my_media.play()
    else
      my_media.play()

  @pauseAudio = () ->
    if my_media?
      my_media.pause()
      media_record_result.innerHTML = "Playback paused!"

  @stopAudio = () ->
    if my_media?
      my_media.stop()
      media_record_result.innerHTML = "Playback stopped!"

  @recordAudio = () ->
    my_media = new Media "lol.wav"
    my_media.startRecord()
    media_record_result.innerHTML = "Recording!"

    setTimeout () ->
      my_media.stopRecord()
      media_record_result.innerHTML = "Recording complete!"
    , 5000


  getPath = () ->
    location.pathname.substring 0, location.pathname.lastIndexOf('/')+1

  # NOTIFICATION TEST
  @alertTest = () ->
    navigator.notification.alert "Hello world!", null, "Cordova alert", "Lol"

  @confirmTest = () ->
    navigator.notification.confirm "Hello world!", null, "Cordova confirm", "Regards, Uncle, Dolan"

  @promptTest = () ->
    navigator.notification.prompt "Hello world!", null

  @beepTest = () ->
    navigator.notification.beep 5

  @vibrateTest = () ->
    navigator.notification.vibrate 500

  # LOCAL STORAGE TEST
  @setItemTest = () ->
    window.localStorage.setItem "items", "apples"
    localStorage_result.innerHTML = "Set an item 'items' with the value 'apples'."

  @getItemTest = () ->
    item = window.localStorage.getItem "items"
    if item?
      localStorage_result.innerHTML = "Got '#{item}'"
    else
      localStorage_result.innerHTML = "Error: could not find the item item-text-wrap"

  @removeItemTest = () ->
    item = window.localStorage.getItem "items"
    if item?
      window.localStorage.removeItem "items"
      localStorage_result.innerHTML = "'items' removed"
    else
      localStorage_result.innerHTML = "Error: could not find the item to be removed"

  # EXIT APP
  @exitAppTest = () ->
    navigator.app.exitApp()

  @testInAppBrowserNOBar = () ->
    url = "http://localhost/views/plugin/index.html"
    target = "_blank"
    options = "location=no"
    ref = cordova.InAppBrowser.open url, target, options

  @testInAppBrowserClearCache = () ->
    url = "http://localhost/views/plugin/index.html"
    target = "_blank"
    options = "location=yes,clearcache=yes"
    ref = cordova.InAppBrowser.open url, target, options

  @testInAppBrowserClearSessionCache = () ->
    url = "http://localhost/views/plugin/index.html"
    target = "_blank"
    options = "location=yes,clearsessioncache=yes"
    ref = cordova.InAppBrowser.open url, target, options

  @testInAppBrowserWithBar = () ->

    appendEvent = (content) =>
      parent = document.getElementById("in-app-browser-status")
      li = document.createElement("li")
      li.innerHTML = "#{content} - time: #{new Date()}"
      parent.appendChild li

    url = "http://www.google.com"
    target = "_blank"
    options = "location=yes"

    appendEvent "open window"

    ref = cordova.InAppBrowser.open url, target, options

    ref.addEventListener "loadstart", () ->
      appendEvent "loadstart"
    ref.addEventListener "loadstop", () ->
      appendEvent "loadstop"
    ref.addEventListener "loaderror", () ->
      appendEvent "loaderror"
    ref.addEventListener "exit", () ->
      appendEvent "exit"

  @testNativeInputShow = () ->
    params =
      rightButton:
        styleClass: 'send-button'
      input:
        placeHolder: 'Type your message here'
        type: 'normal'
        lines: 1

    cordova.plugins.NativeInput.show params

  @testNativeInputShow_style = () ->
    params =
      leftButton:
        styleCSS: 'text:hellow;color:blue;background-color:green;'
      rightButton:
        styleClass: 'myRightButtonClass'
        cssId: 'myRightButton'
      panel:
        styleClass: 'grey-panel'
      input:
        placeHolder: 'Type your message here'
        type: 'uri'
        lines: 2
        styleClass: 'myInputClass'
        styleId: 'myInputId'

    cordova.plugins.NativeInput.show params

  @testNativeInputShow_email = () ->
    params =
      input:
        placeHolder: 'Chat box'
        type: 'email'
        lines: 1

    cordova.plugins.NativeInput.show params

  @testNativeInputKeyboardAction = () ->
    cordova.plugins.NativeInput.onKeyboardAction true, (action) ->
      keyboardAction = document.getElementById("keyboardAction")
      keyboardAction.innerHTML = keyboardAction.innerHTML + "action: #{action}<br>"

  @testNativeInputCloseKeyboard = () ->
    cordova.plugins.NativeInput.closeKeyboard()

  @testNativeInputOnButtonAction = () ->
    cordova.plugins.NativeInput.onButtonAction (button) ->
      buttonAction = document.getElementById("buttonAction")
      buttonAction.innerHTML = buttonAction.innerHTML + "button: #{button}<br>"

  @testNativeInputHide = () ->
    cordova.plugins.NativeInput.hide()

  @testNativeInputOnChange = () ->
    cordova.plugins.NativeInput.onChange (value) ->
      nativeInputValue1 = document.getElementById("nativeInputValue1")
      nativeInputValue1.innerHTML = value

  @testNativeInputGetValue = () ->
    cordova.plugins.NativeInput.getValue (value) ->
      nativeInputValue2 = document.getElementById("nativeInputValue2")
      nativeInputValue2.innerHTML = value
