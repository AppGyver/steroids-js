function fileSystemURITest() {
  window.resolveLocalFileSystemURI("file://" + window.applicationFullPath  + "/cordova/lol.txt", function(fileEntry) {
    alert("Success: " + fileEntry.name);
  }, function(jotain) {
    alert("Failure: " + xinspect(jotain));
  });
}

function readFileTest() {
    window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, gotFS, fileTestFail);
}

function gotFS(fileSystem) {
  alert("Got file system with root path: " + fileSystem.root.fullPath);
  fileSystem.root.getFile(window.applicationPath + "/cordova/lol.txt", null, gotFileEntry, fileTestFail);
}

function gotFileEntry(fileEntry) {
  alert("Got file entry with path: " + fileEntry.fullPath);
  fileEntry.file(gotFile, fileTestFail);
}

function gotFile(file){
  alert("Got file: " + file.name + "\n" +
        "Full path: " + file.fullPath + "\n" +
        "Mime type: " + file.type + "\n" +
        "Last modified: " + file.lastModifiedDate + "\n" +
        "Size in bytes: " + file.size);
    readDataUrl(file);
    readAsText(file);
}

function readDataUrl(file) {
    var reader = new FileReader();
    reader.onloadend = function(evt) {
        alert("Read as data URL: " + evt.target.result);
    };
    reader.readAsDataURL(file);
}

function readAsText(file) {
    var reader = new FileReader();
    reader.onloadend = function(evt) {
        alert("Read as text: " + evt.target.result);
    };
    reader.readAsText(file);
}

function fileTestFail(evt) {
    alert("FILETESTFAIL: " + xinspect(evt));
}
