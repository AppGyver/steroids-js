(function(previousOnError) {

window.onerror = function(errorMsg, url, lineNumber) {
  var formattedMsg = url+":"+lineNumber+" "+errorMsg;
  console.log(formattedMsg);
  alert(formattedMsg);

  if (previousOnError) {
    previousOnError(errorMsg, url, lineNumber);
  };
};

})(window.onerror);