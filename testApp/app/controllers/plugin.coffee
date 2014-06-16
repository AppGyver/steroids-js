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
