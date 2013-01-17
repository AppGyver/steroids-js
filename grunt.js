module.exports = function(grunt) {
  grunt.file.defaultEncoding = 'utf8';
  // Project configuration.
  var documentationSourceFiles = [
//    'docs/Steroids.html',
    'docs/App.html',
    'docs/Animation.html',
    'docs/Audio.html',
    'docs/Button.html',
    'docs/Camera.html',
    'docs/Device.html',
    'docs/Flash.html',
    'docs/NavigationBar.html',
    'docs/LayerCollection.html',
    'docs/Layer.html',
    'docs/Tab.html'
//    'docs/NativeObject.html',
//    'docs//Bridge.html',
//    'docs//WebsocketBridge.html'
  ]

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
          '<file_strip_banner:lib/NativeObject.js>',
          '<file_strip_banner:lib/models/Device.js>',
          '<file_strip_banner:lib/models/Animation.js>',
          '<file_strip_banner:lib/models/App.js>',
          '<file_strip_banner:lib/models/Button.js>',
          '<file_strip_banner:lib/models/Modal.js>',
          '<file_strip_banner:lib/models/LayerCollection.js>',
          '<file_strip_banner:lib/models/Layer.js>',
          '<file_strip_banner:lib/models/Tab.js>',
          '<file_strip_banner:lib/models/NavigationBar.js>',
          '<file_strip_banner:lib/models/Audio.js>',
          '<file_strip_banner:lib/models/Flash.js>',
          '<file_strip_banner:lib/models/Camera.js>',
          '<file_strip_banner:lib/Steroids.js>'
        ],
        dest: 'dist/steroids.js',
        separator: ';'
      },
      docs_by_version: {
        src: documentationSourceFiles,
        dest: 'docs/<%= pkg.name %>-<%= pkg.version %>.html',
        separator: '<hr>'
      },
      docs_latest_version: {
        src: documentationSourceFiles,
        dest: 'docs/<%= pkg.name %>-latest.html',
        separator: '<hr>'
      }
    },

    shell: {
      generate_documentation: {
        command: 'npm run-script gdocs'
      }
    }
  });

  grunt.registerTask('wrap', 'Wrap steroids.js to anonymous function so it does not pollute the global namespace', function(){
    var content = grunt.file.read("dist/steroids.js");
    grunt.file.write("dist/steroids.js", "(function(window){\n"+content+"\n})(window)\n");
  })

  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-coffee');

  // Default task.
  grunt.registerTask('default', 'coffee concat:dist wrap shell:generate_documentation concat:docs_by_version concat:docs_latest_version');
};
