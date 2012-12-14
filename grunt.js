module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',
    meta: {
      banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %> */'
    },
    coffee: {
      app: {
        src: ['src/**/*.coffee'],
        dest: 'lib/',
        options: {
            bare: true,
            preserve_dirs: true,
            base_path: "src"
        }
      }
    },

    watch: {
        files: ['src/**/*'],
        tasks: 'coffee concat'
    },

    concat: {
      dist: {
        src: ['<banner>',
              '<file_strip_banner:lib/SteroidsNativeObject.js>',
              '<file_strip_banner:lib/models/Layer.js>',
              '<file_strip_banner:lib/models/Tab.js>',
              '<file_strip_banner:lib/models/NavigationBar.js>',
              '<file_strip_banner:lib/Steroids.js>'],
        dest: 'dist/steroids.js',
        separator: ';'
      }
    }
  });

  // Load tasks from "grunt-sample" grunt plugin installed via Npm.
  grunt.loadTasks('grunt-sample');
  grunt.loadNpmTasks('grunt-coffee');

  // Default task.
  grunt.registerTask('default', 'coffee');

};