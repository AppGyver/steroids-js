class window.PluginController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "Plugin" }

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
      pause_event.innerHTML = "YES"

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
