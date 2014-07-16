class window.PluginController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "Plugin" }

    list = document.getElementById("ready")
    el = document.createElement("li")
    el.innerHTML = (new Date()).toLocaleTimeString() + " Cordova READY";
    list.appendChild(el);

    #alert "deviceready !"

  # Steroids ready event 
  steroids.on 'ready' ,->

    list = document.getElementById("ready");
    el = document.createElement("li");
    el.innerHTML = (new Date()).toLocaleTimeString() + " Steroids READY";
    list.appendChild(el);


  # ACCELEROMETER TEST

  accelerometerOnSuccess = (acceleration) ->
    accel_x.innerHTML = acceleration.x;
    accel_y.innerHTML = acceleration.y;
    accel_z.innerHTML = acceleration.z;
    accel_timestamp.innerHTML = acceleration.timestamp;

  accelerometerOnError= () ->
    alert 'accelerometer onError!'


  # TODO: the success callback function continues to fire forever and ever
  @accelerometerTest = () ->
    navigator.accelerometer.getCurrentAcceleration accelerometerOnSuccess, accelerometerOnError

  watchId = undefined
  @watchAccelerationTest = () ->
    options =
      frequency: 100
    watchId = navigator.accelerometer.watchAcceleration accelerometerOnSuccess, accelerometerOnError
    alert "watching acceleration"

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
        alert "the user cancelled the scan"
      else
        qr_result.innerHTML = result.text
    ,
    (error) ->
      alert "scanning failed: " + error

  # CAMERA TEST

  cameraOnSuccess = (imageData) ->
    image = document.querySelector '#cameraTest'
    image.src = "data:image/jpeg;base64," + imageData;


  cameraOnFail = (message) ->
    alert 'Failed because: ' + message


  @cameraGetPictureTest = () ->
    navigator.camera.getPicture cameraOnSuccess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL
    }

  modalOpenedSuccess = () ->
    alert "modal opened on the camera callback !"

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
      destinationType: Camera.DestinationType.DATA_URL,
      sourceType: Camera.PictureSourceType.PHOTOLIBRARY
    }

  @cameraGetPictureOpenModalTest = () ->
    navigator.camera.getPicture openModalOnSucess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL
    }

  @cameraCleanupTest = () ->
    navigator.camera.cleanup(
      () ->
        alert "Camera cleanup success"
      (message) ->
        alert "Camera cleanup failed: " + message
    )

  @cameraFromPhotoLibraryTest = () ->
    navigator.camera.getPicture cameraOnSuccess, cameraOnFail, {
      quality: 50
      destinationType: Camera.DestinationType.DATA_URL,
      sourceType: Camera.PictureSourceType.PHOTOLIBRARY
    }

  fileError = (error)->
    alert "Cordova error code: " + error.code, null, "File system error!"

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
      encodingType: Camera.EncodingType.PNG
    }

  @cameraFromPhotoLibrarySaveInUserFilesTest = () ->
    navigator.camera.getPicture saveInUserFilesOnSuccess, cameraOnFail, {
      sourceType: Camera.PictureSourceType.PHOTOLIBRARY
      quality: 50
      destinationType: Camera.DestinationType.FILE_URI
      encodingType: Camera.EncodingType.PNG
    }

  # CAPTURE TEST

  captureOnSuccess = (mediaFiles) ->
    for item in mediaFiles
      alert item.fullPath

  captureOnError = (error) ->
    alert 'Capture error, error code: ' + error.code


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
    alert 'CompassError: ' + error.code

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
    # alert doesn't work with pause so need to edit DOM
    document.addEventListener "pause", () ->
      pause_result.innerHTML = "YES"

    alert "Event listener added: pause"

  @addResume = () ->
    # alert needs to be wrapped in setTimeout to work
    document.addEventListener "resume", () ->
      setTimeout () ->
       alert "resume got triggered!"
      , 0

    alert "Event listener added: resume"

  @addOnline = () ->
    document.addEventListener "online", () ->
      online_result.innerHTML = "YES"

    alert "Event listener added: online"

  @addOffline = () ->
    document.addEventListener "offline", () ->
      offline_result.innerHTML = "YES"

    alert "Event listener added: offline"

  @addBatteryCritical = () ->
    window.addEventListener "batterycritical", (status) ->
      alert "Device's battery level is critical, with  #{status.level}
        % battery life. \n
        Is it plugged in? #{status.isPlugged}"

    alert "Event listener added: batterycritical"

  @addBatteryLow = () ->
    window.addEventListener "batterylow", (status) ->
      alert "Device's battery level is low, with  #{status.level}
        % battery life. \n
        Is it plugged in? #{status.isPlugged}"

    alert "Event listener added: batterylow"

  @addBatteryStatus = () ->
    window.addEventListener "batterystatus", (status) ->
      alert "Device's battery level was changed by at least 1%, with  #{status.level}
        % battery life. \n
        Is it plugged in? #{status.isPlugged}"

    alert "Event listener added: batterystatus"

  @addBackButton = () ->

    handler = () ->
      alert "Device's back button pressed !"

    document.addEventListener "backbutton", handler, false

    alert "Event listener added: backbutton"

  @addMenuButton = () ->

    handler = () ->
      alert "Menu button pressed !"

    document.addEventListener "menubutton", handler, false

    alert "Event listener added: menubutton"

  @addSearchButton = () ->

    handler = () ->
      alert "searchbutton button pressed !"

    document.addEventListener "searchbutton", handler, false

    alert "Event listener added: searchbutton"

  # FILE TEST

  testFS = undefined
  @getFileSystemTest = () ->
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, gotFS, fileTestFail

  @readFileTest = () ->
    if testFS?
      testFS.root.getFile "lol.txt", {create:true}, gotFileEntry, fileTestFail
    else
      alert "Request a fileSystem with the 'Get fileSystem' test first"

  @writeFileTest = () ->
    if testFS?
      testFS.root.getFile "lol.txt", {create:true}, gotFileToWrite, fileTestFail
    else
      alert "Request a fileSystem with the 'Get fileSystem' test first"

  @deleteFileTest = () ->
    if testFS?
      testFS.root.getFile "lol.txt", {create:false}, gotFileToDelete, fileTestFail
    else
      alert "Request a fileSystem with the 'Get fileSystem' test first"

  gotFS = (fileSystem) ->
    alert "Got file system with root path: " + fileSystem.root.fullPath
    testFS = fileSystem

  gotFileEntry = (fileEntry) ->
    alert "Got file entry with path: " + fileEntry.fullPath
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
    alert "Got file: #{file.name} \n
          Full path: #{file.fullPath} \n
          Mime type: #{file.type} \n
          Last modified: #{file.lastModifiedDate} \n
          Size in bytes: #{file.size}"
    readDataUrl(file);
    readAsText(file);

  readDataUrl = (file) ->
    reader = new FileReader()
    reader.onloadend = (evt) ->
      alert "Read as data URL: " + evt.target.result

    reader.readAsDataURL file

  readAsText = (file) ->
    reader = new FileReader()
    reader.onloadend = (evt) ->
      file_result.innerHTML = "
        Contents of #{file.name}: \n
        #{evt.target.result}"

    reader.readAsText file

  fileTestFail = (evt) ->
      alert "FILETESTFAIL: " + JSON.stringify evt


  imageFileURL = undefined

  @fileURLTest = () ->
    if testFS?
      testFS.root.getFile "image.png", {create:true}, gotImage, imageTestFail
    else
      alert "Request a fileSystem with the 'Get fileSystem' test first"

  @URLtoFileEntryTest = () ->
    if testFS?
      window.resolveLocalFileSystemURL imageFileURL, (fileEntry)->
        fileURL_result.innerHTML = "fileEntry.fullPath: " + fileEntry.fullPath
      , imageTestFail
    else
      alert "Request a fileSystem with the 'Get fileSystem' test first"

  gotImage = (fileEntry) ->
    imageFileURL = fileEntry.toURL()
    fileURL_result.innerHTML = "fileEntry.toURl(): #{imageFileURL}"

  imageTestFail = (error) ->
    fileURL_result.innerHTML = "Error resolving fileEntry: " + JSON.stringify error

  #FILETRANSFER TEST

  @downloadTest = () ->
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, (fs) ->
      fileTransfer = new FileTransfer()
      filePath = fs.root.toURL() + "/test.response"
      uri = encodeURI "http://docs.appgyver.com/en/stable/index.html"

      fileTransfer.download(
        uri
        filePath
        (entry) ->
          fileTransfer_result.innerHTML = "download complete: " + entry.fullPath
        (error) ->
          fileTransfer_result.innerHTML = "
            download error source: #{error.source} \n
            download error target: #{error.target} \n
            download error code: #{error.code}"
        false
        {}
      )
    , (error) ->
      fileTransfer_result.innerHTML = "Requesting fileSystem failed: " + JSON.stringify error

  @downloadRedirectTest = () ->
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, (fs) ->
      fileTransfer = new FileTransfer()
      filePath = fs.root.toURL() + "/test.redirect.response"
      uri = encodeURI "http://cloud.appgyver.com/applications/" # redirects to /users/sign_in

      fileTransfer.download(
        uri
        filePath
        (entry) ->
          fileTransfer_result.innerHTML = "download complete: " + entry.fullPath
        (error) ->
          fileTransfer_result.innerHTML = "
            download error source: #{error.source} \n
            download error target: #{error.target} \n
            download error code: #{error.code}"
        false
        {}
      )
    , (error) ->
      fileTransfer_result.innerHTML = "Requesting fileSystem failed: " + JSON.stringify error

  @downloadAuthTest = () ->
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, (fs) ->
      fileTransfer = new FileTransfer()
      filePath = fs.root.toURL() + "/test.auth.response"
      uri = encodeURI "https://api.flowdock.com/flows/flemy/main/files/XaD24A7P0l_M__E4B1YBUw/20130624_130747.jpg" # redirects to acual image

      fileTransfer.download(
        uri
        filePath
        (entry) ->
          fileTransfer_result.innerHTML = "download complete: " + entry.fullPath
        (error) ->
          fileTransfer_result.innerHTML = "
            download error source: #{error.source} \n
            download error target: #{error.target} \n
            download error code: #{error.code}"
        false
        {
          headers: { "Authorization": "Basic NjBlMDQ1MTE5NWZhZDY4OTg5OTU5NGE4Zjg0YzNjYmE6bnVsbA==" }
        }
      )
    , (error) ->
      fileTransfer_result.innerHTML = "Requesting fileSystem failed: " + JSON.stringify error

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
    alert "
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
      localStorage_result.innerHTML = "Error: could not find the item"
  
  @removeItemTest = () ->
    item = window.localStorage.getItem "items"
    if item?
      window.localStorage.removeItem "items"
      localStorage_result.innerHTML = "'items' removed"
    else
      localStorage_result.innerHTML = "Error: could not find the item to be removed"
    


