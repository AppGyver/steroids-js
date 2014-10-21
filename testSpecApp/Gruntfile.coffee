module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-steroids"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-shell"

  grunt.initConfig
    copy:
      "steroids-dist":
        src: "../dist/steroids.js"
        dest: "www/components/steroids-js/steroids.js"
    shell:
      "steroids-build":
        command: "grunt"
        options:
          execOptions:
            cwd: '..'

  grunt.registerTask "default", [
    "shell:steroids-build"
    "copy:steroids-dist"
    "steroids-make"
    "steroids-compile-sass"
  ]
