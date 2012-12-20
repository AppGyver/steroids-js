path = require("path");
fs = require("fs");
coffee = (typeof(steroidsPath) !== "undefined") ? require(path.join(steroidsPath, "node_modules", "coffee-script")) : require("coffee-script");
wrench = (typeof(steroidsPath) !== "undefined") ? require(path.join(steroidsPath, "node_modules", "wrench")) : require("wrench");

module.exports = function(grunt) {

  grunt.initConfig({

  });

  grunt.registerTask('default', ['steroids-clean-dist', 'steroids-copy-www', 'steroids-copy-vendor', 'steroids-generate-views', 'steroids-compile-coffeescripts', 'steroids-concat', 'steroids-remove-dist-models']);


  /* Steroids Tasks & functions: */
  (function(grunt){

    var buildDirectory            = path.join(process.cwd(), "dist"),
        buildViewsDirectory       = path.join(buildDirectory, "views"),
        buildModelsDirectory      = path.join(buildDirectory, "models"),
        buildcontrollersDirectory = path.join(buildDirectory, "controllers"),
        appDirectory              = path.join(process.cwd(), "app"),
        appViewsDirectory         = path.join(appDirectory, "views"),
        appModelsDirectory        = path.join(appDirectory, "models"),
        appControllersDirectory   = path.join(appDirectory, "controllers"),
        appLayoutsDirectory       = path.join(appDirectory, "views", "layouts"),
        vendorDirectory           = path.join(process.cwd(), "vendor"),
        wwwDirectory              = path.join(process.cwd(), "www");


    var compileCoffee = function(filePath, baseDir, newDirPrefix){
      if (typeof(newDirPrefix) === "undefined")
        var newDirPrefix = "";

      var compiledSource = coffee.compile(grunt.file.read(filePath, "utf8").toString());

      var fileBuildPath = filePath.replace(baseDir, path.join(buildDirectory, newDirPrefix)).replace(/\.coffee/, ".js");

      grunt.file.write(fileBuildPath, compiledSource);

    }

    grunt.registerTask('steroids-compile-coffeescripts', "Compiles coffeescripts from app/models/* app/controllers/* and vendor/appgyver/*", function(){

      [appModelsDirectory, appControllersDirectory].forEach(function(directory){

        grunt.file.expand(directory+path.sep+"**"+path.sep+"*.coffee").forEach(function(filePath){

          compileCoffee(filePath, appDirectory);

        });

      });


      grunt.file.expand(vendorDirectory+path.sep+"**"+path.sep+"*.coffee").forEach(function(filePath){

        compileCoffee(filePath, vendorDirectory, "vendor");

      });

    });

    grunt.registerTask('steroids-concat', 'Concat steroids project files in dist/', function(){
      var jsArr=[];
      grunt.file.expand(grunt.file.expandFiles(buildModelsDirectory + path.sep + "**" + path.sep + "*")).forEach(function(filePath){
        jsArr.push(grunt.file.read(filePath, "utf8").toString());
      });
      grunt.file.write(path.join(buildModelsDirectory, "models.js"), jsArr.join("\n"));
    });

    grunt.registerTask('steroids-copy-www', 'Copy www/ content over dist/', function(){

      wrench.copyDirSyncRecursive(wwwDirectory, buildDirectory)

    });

    grunt.registerTask('steroids-copy-vendor', 'Copy vendor/ to dist/vendor', function(){

      grunt.file.expandFiles(vendorDirectory + path.sep + "**" + path.sep + "*").forEach(function(filePathPart){
        if ( !/\.coffee$/.test( path.basename(filePathPart) ) ) {
          var filePath = path.resolve(filePathPart),
              buildFilePath = path.resolve(filePathPart.replace("vendor"+path.sep, "dist"+path.sep+"vendor"+path.sep));


          grunt.file.copy(filePath, buildFilePath);

        }

      })

    });


    grunt.registerTask('steroids-clean-dist', 'Removes dist/ recursively and creates it again ', function(){

      wrench.rmdirSyncRecursive(buildDirectory, true);

      grunt.file.mkdir(buildDirectory);

      ["views", "models", "controllers", "vendor"].forEach(function(suffix){

        grunt.file.mkdir(path.join(buildDirectory, suffix));

      });

    });

    grunt.registerTask('steroids-remove-dist-models', 'Remove single model files from build dir', function(){
      var buildModelFiles = grunt.file.expandFiles(buildModelsDirectory + path.sep + "**" + path.sep + "*");

      buildModelFiles.forEach(function(filePath){

        if (path.basename(filePath) !== "models.js") fs.unlink(filePath);

      });

    });

    grunt.registerTask('steroids-generate-views', 'HTML files from app/layouts/application & app/**/* files', function() {
      var viewDirectories = [];

      // get each view folder (except layout)
      grunt.file.expandDirs(appViewsDirectory + path.sep + "*").forEach(function(dirPath){

        if (path.basename(dirPath) !== "layouts"+path.sep && path.basename(dirPath) !== "layouts") {

          viewDirectories.push(dirPath);

          grunt.file.mkdir(path.join(buildViewsDirectory, path.basename(dirPath)));
        }
      });


      viewDirectories.forEach(function(viewDir){

        // resolve layout file for these views
        var layoutFileName;

        // Some machines report folder/ as basename while others do not
        if(path.basename(viewDir).indexOf(path.sep) != -1) {
          layoutFileName = path.basename(viewDir).replace(path.sep, ".html")
        } else {
          layoutFileName = path.basename(viewDir) + ".html"
        }

        var layoutFilePath = path.join(appLayoutsDirectory, layoutFileName);

        if (!fs.existsSync(layoutFilePath)) layoutFilePath = path.join(appLayoutsDirectory, "application.html");

        applicationLayoutFile = grunt.file.read(layoutFilePath, "utf8"),


        grunt.file.expand(viewDir + path.sep + "**" + path.sep + "*").forEach(function(filePathPart){

          var filePath = path.resolve(filePathPart),
              buildFilePath = path.resolve(filePathPart.replace("app"+path.sep, "dist"+path.sep));

          var controllerName = path.basename(viewDir).replace(path.sep, "") + "Controller";
          var yieldObj = {
            view: grunt.file.read(filePath, "utf8"),
            controller: controllerName
          }

          // put layout+yields together
          var yieldedFile = grunt.util._.template(applicationLayoutFile.toString())({yield: yieldObj})


          // write the file
          grunt.file.mkdir(path.dirname(buildFilePath));
          grunt.file.write(buildFilePath, yieldedFile);

        });

      });

    });
  })(grunt);




};