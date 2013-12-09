// When using iOS simulator, the first console.log messages might not appear before Cordova has overridden the console.log
// Here we buffer the messages and output when override is done.

(function(window) {

  var logMessages = [];

  var defaultConsoleLog = window.console.log;

  window.console.log = function(args) {
    logMessages.push(args);
  }

  var bufferConsoleLogUntilReadyAndFlush = function() {
    var cordovaOverride = "logWithArgs";
    var isNative = "[native code]";

    if ( (defaultConsoleLog.toString().indexOf(cordovaOverride) > -1) ||
         (defaultConsoleLog.toString().indexOf(isNative) > -1) ) {
      window.console.log = defaultConsoleLog;
      for (var i=0; i<logMessages.length; i++) {
        console.log(logMessages.pop());
      }

    } else {

      window.setTimeout(function() {
        bufferConsoleLogUntilReadyAndFlush();
      }, 100);

    }

  }

  bufferConsoleLogUntilReadyAndFlush();

})(window);