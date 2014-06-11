// ACCELEROMETER TEST

function accelerometerOnSuccess(acceleration) {
    accel_x.innerHTML = acceleration.x;
    accel_y.innerHTML = acceleration.y;
    accel_z.innerHTML = acceleration.z;
    accel_timestamp.innerHTML = acceleration.timestamp;
};

function accelerometerOnError() {
    alert('accelerometer onError!');
};


// TODO: the success callback function continues to fire forever and ever
function accelerometerTest() {

  navigator.accelerometer.getCurrentAcceleration(accelerometerOnSuccess, accelerometerOnError);
}

// ------------------------------------------------------------
// BARCODESCANNER TEST

function BarCodeScan() {
  cordova.plugins.barcodeScanner.scan(function(result) {
    if (result.cancelled) {
      alert("the user cancelled the scan");
    } else {
      qr_result.innerHTML = result.text;
    }
  },
  function(error) {
      alert("scanning failed: " + error)
  });
}


// ------------------------------------------------------------
// CALENDAR TEST

function calendarInit() {
  window.plugins.calendarPlugin.initialize(function() {
    alert("Calendar initialized and haz access!");
  }, function() {
    alert("Calendar failed to initialize because it haz no access!");
  });
}

function calendarCreateEvent() {
  var title = "Dolan Event";
  var loc = "Dolan's Shack";
  var notes = "Very gud event!";
  var startDate = "2013-09-06 09:30:00";
  var endDate = "2013-09-06 12:30:00";
  var createSuccess = function() {
    // Native dialogue appears on success callback
  }
  var createFailure = function() {
    alert("Failed to create event!");
  }

  window.plugins.calendarPlugin.createEvent(title,loc,notes,startDate,endDate,createSuccess,createFailure);
}

function calendarGetEvents() {
  today = new Date();
  //                                     d   hh   mm   ss   ms
  nextWeek = new Date(today.getTime() + (7 * 24 * 60 * 60 * 1000));

  // "yyyy-MM-dd HH:mm:ss"
  start = "" + today.getFullYear() + "-" + (today.getMonth()+1) + "-" + today.getDate() + " " + today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds()
  end = "" + nextWeek.getFullYear() + "-" + (nextWeek.getMonth()+1) + "-" + nextWeek.getDate() + " " + nextWeek.getHours() + ":" + nextWeek.getMinutes() + ":" + nextWeek.getSeconds()

  window.plugins.calendarPlugin.findEvent(null,null,null,start, end, function(result) {
    alert("Found " + result.length + " events!");

    // event attributes:
    // - availability
    // - startDate
    // - endDate
    // - allDay
    // - isDetached
    // - organizer
    // - status
    // - calendar
    // - title
    // - location
    // - creationDate
    // - lastModifiedDate
    // - timezone
    // - URL
    // - message
    // - attendees
    console.log(JSON.stringify(result));

  }, function(error) {
    alert("Found 0 events... :( error msg: " + error);
  });
}

// ------------------------------------------------------------
// CAMERA TEST

function cameraOnSuccess(imageData) {
  alert("Camera success!");
    var image = document.querySelector('myImage');
    image.src = "data:image/jpeg;base64," + imageData;
}

function cameraOnFail(message) {
    alert('Failed because: ' + message);
}

function cameraTestGetPicture() {
  navigator.camera.getPicture(cameraOnSuccess, cameraOnFail, { quality: 50,
    destinationType: Camera.DestinationType.DATA_URL
  });
}

function cameraTestFromPhotoLibrary() {
  navigator.camera.getPicture(cameraOnSuccess, cameraOnFail, { quality: 50,
    destinationType: Camera.DestinationType.DATA_URL,
    sourceType: Camera.PictureSourceType.PHOTOLIBRARY
  });
}

// ------------------------------------------------------------
// CAPTURE TEST


function captureOnSuccess(mediaFiles) {
  var i, len;
      for (i = 0, len = mediaFiles.length; i < len; i += 1) {
          alert(mediaFiles[i].fullPath);
      }
}

function captureOnError(error) {
  alert('Capture error, error code: ' + error.code);
}

function captureTestAudio() {
  navigator.device.capture.captureAudio(captureOnSuccess, captureOnError,{});
}

function captureTestImage() {
  navigator.device.capture.captureImage(captureOnSuccess, captureOnError,{limit:1});
}

function captureTestVideo() {
  navigator.device.capture.captureVideo(captureOnSuccess, captureOnError,{});
}

// ------------------------------------------------------------
// COMPASS TEST

function compassOnSuccess(heading) {
    alert('Heading: ' + heading.magneticHeading);
};

function compassOnError(error) {
    alert('CompassError: ' + error.code);
};

function compassTest() {
  navigator.compass.getCurrentHeading(compassOnSuccess, compassOnError);
}

// ------------------------------------------------------------
// CONNECTION TEST

function connectionTest() {
    var networkState = navigator.network.connection.type;

    var states = {};
    states[Connection.UNKNOWN]  = 'Unknown connection';
    states[Connection.ETHERNET] = 'Ethernet connection';
    states[Connection.WIFI]     = 'WiFi connection';
    states[Connection.CELL_2G]  = 'Cell 2G connection';
    states[Connection.CELL_3G]  = 'Cell 3G connection';
    states[Connection.CELL_4G]  = 'Cell 4G connection';
    states[Connection.NONE]     = 'No network connection';

    alert('Connection type: ' + states[networkState]);
}

// ------------------------------------------------------------
// CONTACTS TEST

var myContact;
function contactsSaveOnSuccess(contact) {
    contacts_result.innerHTML = ("Save Success: " + contact.nickname + " created in Contacts.");
};

function contactsSaveOnError(contactError) {
    contacts_result.innerHTML = ("Contact save error = " + contactError.code);
};

function contactsSaveTest() {
  var myContact = navigator.contacts.create({"displayName": "Dolan Duck", "nickname": "Dolan Duck"});
  myContact.note = "GOOBY PLZ"

  var name = new ContactName();
  name.givenName = "Dolan";
  name.familyName = "Duck";
  myContact.name = name;

  myContact.save(contactsSaveOnSuccess, contactsSaveOnError);
}

// CONTACTS FIND TEST

function contactsFindOnSuccess(contacts) {
    contacts_result.innerHTML = ('Found ' + contacts.length + ' contacts matching Dolan.');
};

function contactsFindOnError(contactError) {
    contacts_result.innerHTML = ('Contacts find onError:' + contactError.code);
};

// find all contacts with 'Dolan' in any name field
function contactsFindTest() {
  var options = new ContactFindOptions();
  options.filter="Dolan";
  var fields = ["displayName", "name"];
  navigator.contacts.find(fields, contactsFindOnSuccess, contactsFindOnError, options);
}

// ------------------------------------------------------------
// DATEPICKER TESTS

function datepickerTest() {
  window.plugins.datePicker.show({}, function(date) {
    alert("date picker Success");
  });
}

// ------------------------------------------------------------
// DEVICE TESTS

function deviceTest() {
  alert(
    "Device name: " + device.name + "\n" +
    "Device Cordova: " + device.cordova + "\n" +
    "Device platform: " + device.platform + "\n" +
    "Device UUID: " + device.uuid + "\n" +
    "Device version: " + device.version + "\n"
  );
}

// ------------------------------------------------------------
// EVENTS TESTS
// document.addEventListener("deviceready", onDeviceReady);

// function onDeviceReady() {

function addPause() {
  // alert doesn't work with pause so need to edit DOM
  document.addEventListener("pause", function() {
    document.querySelector("#pause").innerHTML = "pause got triggered!";
  });
  alert("Event listener added: pause");
}

function addResign() {
  document.addEventListener("resign", function() {
    document.querySelector("#resign").innerHTML = "resign got triggered!";
  });
  alert("Event listener added: resign");
}

function addResume() {
  // alert needs to be wrapped in setTimeout to work
  document.addEventListener("resume", function() {
    setTimeout(function() { alert("resume got triggered!"); }, 0);
  });
  alert("Event listener added: resume");
}

function addActive() {
  document.addEventListener("active", function() {
    setTimeout(function() { alert("active got triggered!"); }, 0);
  });
  alert("Event listener added: active");
}

function addOnline() {
  document.addEventListener("online", function() {
    document.querySelector("#online").innerHTML = "online got triggered!";
  });
  alert("Event listener added: online");
}

function addOffline() {
  document.addEventListener("offline", function() {
    document.querySelector("#offline").innerHTML = "offline got triggered!";
  });
  alert("Event listener added: offline");
}

function addBatteryCritical() {
  window.addEventListener("batterycritical", function(status) {
    alert("Device's battery level is critical, with " + status.level + "% battery life. \n" +
          "Is it plugged in? " + status.isPlugged);
  });
  alert("Event listener added: batterycritical");
}

function addBatteryLow() {
  window.addEventListener("batterylow", function(status) {
    alert("Device's battery level is low, with " + status.level + "% battery life. \n" +
          "Is it plugged in? " + status.isPlugged);
  });
  alert("Event listener added: batterylow");
}

function addBatteryStatus() {
  window.addEventListener("batterystatus", function(status) {
    alert("Device's battery level was changed by at least 1%, with " + status.level + "% battery life currently. \n" +
          "Is it plugged in? " + status.isPlugged);
  });
  alert("Event listener added: batterystatus");
}

// ------------------------------------------------------------
// FACEBOOK TEST

function facebookInit() {
  FB.Event.subscribe('auth.login', function(response) {
    alert('auth.login event');
  });

  FB.Event.subscribe('auth.logout', function(response) {
    alert('auth.logout event');
  });

  FB.Event.subscribe('auth.sessionChange', function(response) {
    alert('auth.sessionChange event');
  });

  FB.Event.subscribe('auth.statusChange', function(response) {
    alert('auth.statusChange event');
  });

  FB.init({ appId: "350586231742320", nativeInterface: CDV.FB, useCachedDialogs: false });
}

function facebookLogin() {
  FB.login(function(response) {
    if (response.session) {
      alert('logged in');
    } else {
      alert('not logged in');
    }
  }, {
    scope: "email"
  });
}

function facebookFetch() {
  FB.api('/me/friends', { fields: 'id, name, picture' },  function(response) {
    if (response.error) {
      alert(JSON.stringify(response.error));
    } else {
      alert(JSON.stringify(response.data));
    }
  });
}

function facebookDialog() {
  var params = {
    method: 'feed',
    name: 'Facebook Dialogs',
    link: 'https://developers.facebook.com/docs/reference/dialogs/',
    picture: 'http://fbrell.com/f8.jpg',
    caption: 'Reference Documentation',
    description: 'Dialogs provide a simple, consistent interface for applications to interface with users.'
  };

  FB.ui(params, function(obj) {
    alert("Dialog response: " + JSON.stringify(obj));
  });
}

function facebookLogout() {
  FB.logout(function(response) {
    alert('logged out: ' + JSON.stringify(response));
  });
}


// ------------------------------------------------------------
// FILE TEST

// FOUND IN filetests.js

// ------------------------------------------------------------
// FILETRANSFER TEST

function downloadRedirectTest() {
  window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fs) {
    var fileTransfer = new FileTransfer();
    var filePath = fs.root.fullPath + "/test.response"
    var uri = encodeURI("http://cloud.appgyver.com/applications/"); // redirects to /users/sign_in

    fileTransfer.download(
        uri,
        filePath,
        function(entry) {
            alert("download complete: " + entry.fullPath);
        },
        function(error) {
            console.log("download error source " + error.source);
            console.log("download error target " + error.target);
            alert("download error code" + error.code);
        },
        false,
        {}
    );
  }, function() {});
}

function downloadAuthorizationTest() {
  window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fs) {
    var fileTransfer = new FileTransfer();
    var filePath = fs.root.fullPath + "/test.auth.response"
    var uri = encodeURI("https://api.flowdock.com/flows/flemy/main/files/XaD24A7P0l_M__E4B1YBUw/20130624_130747.jpg"); // redirects to acual image

    fileTransfer.download(
        uri,
        filePath,
        function(entry) {
            alert("download complete: " + entry.fullPath);
        },
        function(error) {
            console.log("download error source " + error.source);
            console.log("download error target " + error.target);
            alert("download error code" + error.code);
        },
        false,
        {
          headers: { "Authorization": "Basic NjBlMDQ1MTE5NWZhZDY4OTg5OTU5NGE4Zjg0YzNjYmE6bnVsbA==" }
        }
    );
  }, function() {});
}

// ------------------------------------------------------------
// GEOLOCATION TEST

var onGeolocationSuccess = function(position) {
    alert('Latitude: '          + position.coords.latitude          + '\n' +
          'Longitude: '         + position.coords.longitude         + '\n' +
          'Altitude: '          + position.coords.altitude          + '\n' +
          'Accuracy: '          + position.coords.accuracy          + '\n' +
          'Altitude Accuracy: ' + position.coords.altitudeAccuracy  + '\n' +
          'Heading: '           + position.coords.heading           + '\n' +
          'Speed: '             + position.coords.speed             + '\n' +
          'Timestamp: '         + position.timestamp                + '\n');
};

// onError Callback receives a PositionError object
//
function onGeolocationError(error) {
    alert('code: '    + error.code    + '\n' +
          'message: ' + error.message + '\n');
}

function geolocationTest() {
  navigator.geolocation.getCurrentPosition(onGeolocationSuccess, onGeolocationError);
}

// ------------------------------------------------------------
// GENERIC PUSH TEST

function onNotificationAPN(event) {
    if (event.alert) {
        navigator.notification.alert(event.alert);
    }

    if (event.sound) {
        var snd = new Media(event.sound);
        snd.play();
    }

    if (event.badge) {
        window.plugins.pushNotification.setApplicationIconBadgeNumber(function() {
          alert("GENERIC PUSH GOT BADGE AND SET BADGE");
        }, event.badge);
    }
}
function GenericPushInit() {
  window.plugins.pushNotification.register(function(token) {
    alert("GENERIC PUSH INIT GOT TOKEN " + token);
  }, function() {
    alert("GENERIC PUSH INIT FAIL");
  }, {
    "badge":"true",
    "sound":"true",
    "alert":"true",
    "ecb":"onNotificationAPN",
    "senderID":"945551693073" // Juhas sekrit project id associated with Juhas debug cert
  });
}

// ------------------------------------------------------------
// GOOGLE ANALYTICS TEST

function GAInit() {
  // 1) success - a function that will be called on success
  // 2) fail - a function that will be called on error.
  // 3) id - Your Google Analytics account ID of the form; UA-XXXXXXXX-X This is the account ID you were given when you signed up.
  // 4) period - An integer containing the minimum number of seconds between upload of metrics. When metics are logged, they are enqued and are sent out in batches based on this value. You'll want to avoid setting this value too low, to limit the overhead of sending data.
  window.plugins.gaPlugin.init(function() {
    alert("GA INIT SUCCESS");
  }, function() {
    alert("GA INit FAIL");
  }, "UA-41334431-1", 10); // 10 == min number of seconds between uploads, UA-ID is juha's personal id
}

function GATrackEvent() {
  // 1)  resultHandler - a function that will be called on success
  // 2)  errorHandler - a function that will be called on error.
  // 3)  category - This is the type of event you are sending such as "Button", "Menu", etc.
  // 4)  eventAction - This is the type of event you are sending such as "Click", "Select". etc.
  // 5)  eventLabel - A label that describes the event such as Button title or Menu Item name.
  // 6)  eventValue - An application defined integer value that can mean whatever you want it to mean.
  window.plugins.gaPlugin.trackEvent( function() {
    alert("GA TRACK SUCCESS");
  }, function() {
    alert("GA TRACK FAILURE");
  }, "Button", "Click", "event only", 1);
}


// ------------------------------------------------------------
// LOCAL NOTIFICATION TEST

function localnotificationTest() {
  window.plugin.notification.local.add({
    // id:         String, // a unique id of the notifiction
    // date:       Date,   // this expects a date object
    message: "LOL", // String, // the message that is displayed
    title: "LOL", // String, // the title of the message
    // repeat:     String, // has the options of daily', 'weekly',''monthly','yearly')
    // badge:      Number, // displays number badge to notification
    // sound:      String, // a sound to be played (iOS & Android)
    foreground: "localnotificationForeground", // String, // a javascript function to be called if the app is running
    background: "localnotificationBackground" // String, // a javascript function to be called if the app is in the background

  });
}

function localnotificationForeground() {
  alert("FORE");
}

function localnotificationBackground() {
  alert("BACK");
}

// ------------------------------------------------------------
// MAP TEST
var geo = {};
geo.onMapMove = function(lat,lon,latDelta,lonDelta) {
  curlat.innerHTML = lat;
  curlon.innerHTML = lon;
}

function mapkitTest() {
  window.plugins.mapKit.setMapData({
    height:320,
    offsetTop: 80,
    diameter: 10000,
    lat: 49.281468,
    lon: -123.104446
  });

  window.plugins.mapKit.onMapCallback = function(pindex) {
    alert('You selected pin : ' + pindex);
  };

  window.plugins.mapKit.showMap();

  window.plugins.mapKit.addMapPins([
    {
      lat: 49.281468,
      lon: -123.104446,
      title: "LOL Title",
      subTitle: "LOL Subtitle",
      imageURL: "file://"+ window.applicationFullPath + "/cordova/assets/icon_1345641682586.png",
      pinColor: "green", // or purple, otherwise red
      index: 69,
      selected: true
    }
  ]);
}

function closeMapKitTest() {
  window.plugins.mapKit.hideMap();
}

// ------------------------------------------------------------
// MEDIA TEST

// Audio player variables
//
var my_media = null;

// Play audio

function playExistingAudioFile() {
  some_media = new Media(window.applicationFullPath+"/generic/rondoalaturca.wav");
  some_media.play();
}

function playAudioFile() {
  if (my_media == null) {
    my_media = new Media(window.applicationFullPath+"/cordova/lol.wav");
    my_media.play();
  } else {
    my_media.play();
  }
}

function pauseAudio() {
    if (my_media) {
        my_media.pause();
        media_record_result.innerHTML = "Playback paused!";
    }
}

function stopAudio() {
    if (my_media) {
        my_media.stop();
        media_record_result.innerHTML = "Playback stopped!";
    }
}

function recordAudio() {
  my_media = null;
  window.resolveLocalFileSystemURI("file://"+window.applicationFullPath+"/cordova", function(dirEntry) {
    dirEntry.getFile("lol.wav", {create: true}, function() {
      my_media = new Media("file://"+window.applicationFullPath+"/cordova/lol.wav");
      my_media.startRecord();
    });
  });

  // Stop recording after 5 sec
  setTimeout(function() { my_media.stopRecord(); media_record_result.innerHTML = "Recording complete!"; }, 5000);
}

// ------------------------------------------------------------
// NOTIFICATION TEST

function testAlert() {
  navigator.notification.alert("Hello world!", null, "Cordova alert", "Lol");
}

function testConfirm() {
  navigator.notification.confirm("Hello world!", null, "Cordova confirm", "Regards, Uncle, Dolan");
}

function testBeep() {
  navigator.notification.beep(5);
}

function testVibrate(milliseconds) {
  if (!milliseconds) {
    milliseconds = 500;
  }

  navigator.notification.vibrate(milliseconds);
}

// ------------------------------------------------------------
// SQLITE TEST

function testSQLitePlugin() {
  var db = window.sqlitePlugin.openDatabase("Database", "1.0", "Demo", -1);

  db.transaction(function(tx) {
    tx.executeSql('DROP TABLE IF EXISTS test_table');
    tx.executeSql('CREATE TABLE IF NOT EXISTS test_table (id integer primary key, data text, data_num integer)');

    tx.executeSql("INSERT INTO test_table (data, data_num) VALUES (?,?)", ["test", 100], function(tx, res) {
      console.log("insertId: " + res.insertId + " -- probably 1"); // check #18/#38 is fixed
      alert("insertId: " + res.insertId + " -- should be valid, probably 1");

      db.transaction(function(tx) {
        tx.executeSql("SELECT data_num from test_table;", [], function(tx, res) {
          console.log("res.rows.length: " + res.rows.length + " -- should be 1");
          alert("res.rows.item(0).data_num: " + res.rows.item(0).data_num + " -- should be 100");
          alert("SUCCESS");
        });
      });
    }, function(e) {
      console.log("ERROR: " + e.message);
      alert("ERROR: " + e.message);
    });
  });
}

// ------------------------------------------------------------
// STORAGE TEST

var db;

function openDatabaseTest() {
  db = window.openDatabase("Database", "1.0", "AG Cordova Demo", 200000);
  databaseLogResults("Database opened!");
}

function dbTransactionTest() {
  db.transaction(executeSomeSQL);
}

function executeSomeSQL(tx) {
  tx.executeSql('DROP TABLE IF EXISTS DEMO');
  tx.executeSql('CREATE TABLE IF NOT EXISTS DEMO (id unique, data)');
  tx.executeSql('INSERT INTO DEMO (id, data) VALUES (1, "First row")', [], databaseInsertSuccess, databaseError);
  tx.executeSql('INSERT INTO DEMO (id, data) VALUES (2, "Second row")', [], databaseInsertSuccess, databaseError);
  tx.executeSql('SELECT * FROM DEMO', [], databaseSelectSuccess, databaseError);
}

function databaseInsertSuccess(tx, results) {
  databaseLogResults("Insert Success!");
  databaseLogResults("Last inserted row ID = " + results.insertId);
}

function databaseSelectSuccess(tx, results) {
  databaseLogResults("Select Success!");
  databaseLogResults("Returned rows = " + results.rows.length);
  for (var i=0; i<results.rows.length; i++) {
      databaseLogResults("Row: " + i + " ID: " + results.rows.item(i).id + " Data:  " + results.rows.item(i).data);
  }
}

function databaseError(error) {
  databaseLogResults("Error processing SQL: " + err.code);
}

function databaseLogResults(string) {
  results_div.innerHTML += string + "<br/>";
}

steroids.on("ready", function() {
  window.applicationPath = steroids.app.path;
  window.applicationFullPath = steroids.app.absolutePath;
});
