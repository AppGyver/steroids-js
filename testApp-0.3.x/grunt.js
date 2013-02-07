path = require("path");
fs = require("fs");
coffee = (typeof(steroidsPath) !== "undefined") ? require(path.join(steroidsPath, "node_modules", "coffee-script")) : require("coffee-script");
wrench = (typeof(steroidsPath) !== "undefined") ? require(path.join(steroidsPath, "node_modules", "wrench")) : require("wrench");

gruntSteroidsDefaults = (typeof(steroidsPath) !== "undefined") ? require(path.join(steroidsPath, "src", "steroids")).GruntDefaults : require("steroids").GruntDefaults;

module.exports = function(grunt) {
  config = gruntSteroidsDefaults.defaultConfig;

  // Add your custom configurations here
  // config.foo = { bar: true, baz: [1,2,3]}'

  grunt.initConfig(config);

  gruntSteroidsDefaults.registerDefaultTasks(grunt);

  // Register your custom grunt tasks here
  // grunt.registerTask("custom", "Description", function() {
  //   grunt.file.write(path.join(process.cwd(), "dist", "README"), "Custom Generated Readme");
  // });

  grunt.registerTask("default", [
    "steroids-default"
  ]);
};
