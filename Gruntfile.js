module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.loadNpmTasks('grunt-replace');

  grunt.file.defaultEncoding = 'utf8';

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    concat: {
      options: {
        stripBanners: true,
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' + '<%= grunt.template.today("yyyy-mm-dd HH:MM") %> */\n' +
                '(function(window){\n',
        footer: '\n})(window);\n'
      },
      dist: {
        src: ['dist/steroids.js'],
        dest: 'dist/steroids.js',
      }
    },

    coffee: {
      compileJoined: {
        options: {
          join: false,
          bare: true,
          separator: ";"
        },
        // Need to define order, some classes depend on each other (Bridges)
        files: {
          'dist/steroids.js': [
            'src/bridges/Bridge.coffee',
            'src/bridges/AndroidBridge.coffee',
            'src/bridges/WebBridge.coffee',
            'src/bridges/WebsocketBridge.coffee',
            'src/bridges/TizenBridge.coffee',
            'src/Events.coffee',
            'src/models/device/Torch.coffee',
            'src/models/Device.coffee',
            'src/models/Animation.coffee',
            'src/models/App.coffee',
            'src/models/Modal.coffee',
            'src/models/DrawerCollection.coffee',
            'src/models/LayerCollection.coffee',
            'src/models/buttons/NavigationBarButton.coffee',
            'src/models/NavigationBar.coffee',
            'src/models/BounceShadow.coffee',
            'src/models/StatusBar.coffee',
            'src/models/views/WebView.coffee',
            'src/models/views/PreviewFileView.coffee',
            'src/models/Audio.coffee',
            'src/models/OAuth2/OAuth2Flow.coffee',
            'src/models/OAuth2/AuthorizationCodeFlow.coffee',
            'src/models/OAuth2/ClientCredentialsFlow.coffee',
            'src/models/OAuth2.coffee',
            'src/models/data/RSS.coffee',
            'src/models/data/TouchDB.coffee',
            'src/models/data/SQLiteDB.coffee',
            'src/models/XHR.coffee',
            'src/models/analytics/Analytics.coffee',
            'src/models/Screen.coffee',
            'src/models/File.coffee',
            'src/models/OpenURL.coffee',
            'src/models/Notifications.coffee',
            'src/PostMessage.coffee',
            'src/steroids.coffee'
          ]
        }
      },
    },

    replace: {
      dist: {
        options: {
          variables: {
            version: '<%= pkg.version %>'
          }
        },
        files: {
          'dist/steroids.js': [ 'dist/steroids.js']
        }
      }
    },

    uglify: {
      options: {
        mangle: true,
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' + '<%= grunt.template.today("yyyy-mm-dd HH:MM") %> */\n'
      },
      strds: {
        files: {
          'dist/steroids.min.js': ['dist/steroids.js']
        }
      }
    },

    watch: {
      files: ['src/**/*'],
      tasks: 'default'
    },

  });

  grunt.registerTask('default', ['coffee',  'concat:dist', 'replace']);
  grunt.registerTask('build', ['default', 'uglify:strds']);
};
