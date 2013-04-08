execSync = require("exec-sync");

module.exports = function(grunt) {
  grunt.file.defaultEncoding = 'utf8';

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
      tasks: 'default'
    },

    concat: {
      dist: {
        src: [
          '<banner>',
          '<file_strip_banner:lib/bridges/Bridge.js>',
          '<file_strip_banner:lib/bridges/AndroidBridge.js>',
          '<file_strip_banner:lib/bridges/WebsocketBridge.js>',
          '<file_strip_banner:lib/Events.js>',
          '<file_strip_banner:lib/models/device/Torch.js>',
          '<file_strip_banner:lib/models/Device.js>',
          '<file_strip_banner:lib/models/Animation.js>',
          '<file_strip_banner:lib/models/App.js>',
          '<file_strip_banner:lib/models/Modal.js>',
          '<file_strip_banner:lib/models/LayerCollection.js>',
          '<file_strip_banner:lib/models/buttons/NavigationBarButton.js>',
          '<file_strip_banner:lib/models/NavigationBar.js>',
          '<file_strip_banner:lib/models/BounceShadow.js>',
          '<file_strip_banner:lib/models/views/WebView.js>',
          '<file_strip_banner:lib/models/views/PreviewFileView.js>',
          '<file_strip_banner:lib/models/Audio.js>',
          '<file_strip_banner:lib/models/OAuth2/OAuth2Flow.js>',
          '<file_strip_banner:lib/models/OAuth2/AuthorizationCodeFlow.js>',
          '<file_strip_banner:lib/models/OAuth2/ClientCredentialsFlow.js>',
          '<file_strip_banner:lib/models/OAuth2.js>',
          '<file_strip_banner:lib/models/data/TouchDB.js>',
          '<file_strip_banner:lib/models/XHR.js>',
          '<file_strip_banner:lib/models/analytics/Analytics.js>',
          '<file_strip_banner:lib/models/Screen.js>',
          '<file_strip_banner:lib/models/File.js>',
          '<file_strip_banner:lib/models/OpenURL.js>',
          '<file_strip_banner:lib/models/Notifications.js>',
          '<file_strip_banner:lib/PostMessage.js>',
          '<file_strip_banner:lib/steroids.js>'
        ],
        dest: 'dist/steroids.js',
        separator: ';'
      }
    },

    replace: {
      dist: {
        options: {
          variables: {
            version: '<%= pkg.version %>',
            timestamp: '<%= grunt.template.today() %>',
            ipAddress: execSync('ifconfig en0 | grep "inet " | cut -f 2 -d " "')
          }
        },
        files: {
          'dist/steroids.js': [ 'dist/steroids.js'],
          'testSlave/www/index.html': ['testSlave/www/index.html.template']
        }
      }
    }
  });

  grunt.registerTask('wrap', 'Wrap steroids.js to anonymous function so it does not pollute the global namespace', function(){
    var content = grunt.file.read("dist/steroids.js");
    grunt.file.write("dist/steroids.js", "(function(window){\n"+content+"\n})(window)\n");
  })

  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-coffee');
  grunt.loadNpmTasks('grunt-replace');

  // Default task.
  grunt.registerTask('default', 'coffee concat:dist wrap replace');

  grunt.registerTask('build', 'coffee concat:dist wrap replace');
};
