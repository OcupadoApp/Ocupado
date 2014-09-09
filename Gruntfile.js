'use strict';
var LIVERELOAD_PORT = 35729;
var SERVER_PORT = 9000;
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
  return connect.static(require('path').resolve(dir));
};

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  // configurable paths
  var ocupadoConfig = {
    app: 'app',
    dist: 'dist/www'
  };

  grunt.initConfig({
    ocupado: ocupadoConfig,
    watch: {
      options: {
        nospawn: true,
        livereload: true
      },
      coffee: {
        files: ['<%= ocupado.app %>/scripts/{,*/}*.coffee'],
        tasks: ['coffee:dist']
      },
      livereload: {
        options: {
          livereload: LIVERELOAD_PORT
        },
        files: [
          '<%= ocupado.app %>/*.html',
          '{.tmp,<%= ocupado.app %>}/styles/{,*/}*.css',
          '{.tmp,<%= ocupado.app %>}/styles/{,*/}*.styl',
          '{.tmp,<%= ocupado.app %>}/scripts/{,*/}*.js',
          '<%= ocupado.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
          '<%= ocupado.app %>/scripts/templates/*.{ejs,mustache,hbs}',
          'test/spec/**/*.js'
        ]
      },
      jst: {
        files: [
          '<%= ocupado.app %>/scripts/templates/*.hbs'
        ],
        tasks: ['handlebars']
      },
      test: {
        options: {
          livereload: 35728
        },
        files: ['.tmp/**/*.js', 'test/**/*.coffee'],
        tasks: ['coffee:test', 'mocha']
      },
      stylus: {
        files: [
          '<%= ocupado.app %>/styles/**/*.styl'
        ],
        tasks: ['stylus']
      }
    },
    connect: {
      options: {
        port: SERVER_PORT,
        // change this to '0.0.0.0' to access the server from outside
        hostname: '0.0.0.0'
      },
      livereload: {
        options: {
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, '.tmp'),
              mountFolder(connect, ocupadoConfig.app)
            ];
          }
        }
      },
      test: {
        options: {
          port: 9001,
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, '.tmp'),
              mountFolder(connect, '.'),
              mountFolder(connect, ocupadoConfig.app)
            ];
          }
        }
      },
      dist: {
        options: {
          middleware: function (connect) {
            return [
              mountFolder(connect, ocupadoConfig.dist)
            ];
          }
        }
      }
    },
    clean: {
      dist: ['.tmp', '<%= ocupado.dist %>/*'],
      server: '.tmp'
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: [
        'Gruntfile.js',
        '<%= ocupado.app %>/scripts/{,*/}*.js',
        '!<%= ocupado.app %>/scripts/vendor/*',
        'test/spec/{,*/}*.js'
      ]
    },
    mocha: {
      all: {
        options: {
          run: true,
          urls: ['http://localhost:<%= connect.test.options.port %>/test/index.html'],
          timeout: 5000,
          bail: false
        }
      }
    },
    coffee: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= ocupado.app %>/scripts',
          src: '{,*/}*.coffee',
          dest: '.tmp/scripts',
          ext: '.js'
        }]
      },
      test: {
        options: {
          bare: true
        },
        files: {
          'test/spec/test.js': 'test/**/*.coffee',
          'test/spec/main.js': 'app/scripts/main.coffee',
          'test/spec/app.js': [
            '!app/scripts/main.coffee',
            'app/scripts/lib/*.coffee',
            'app/scripts/views/*.coffee',
            'app/scripts/models/*.coffee',
            'app/scripts/collections/*.coffee'
           ]
         }
      }
    },
    stylus: {
      compile: {
        options: {
          paths: [
            '<%= ocupado.app %>/styles/includes',
            '<%= ocupado.app %>/styles/rooms'
          ]
        },
        files: {
          '<%= ocupado.app %>/styles/main.css': ['<%= ocupado.app %>/styles/main.styl']
        }
      }
    },
    useminPrepare: {
      html: '<%= ocupado.app %>/index.html',
      options: {
        dest: '<%= ocupado.dist %>'
      }
    },
    usemin: {
      html: ['<%= ocupado.dist %>/{,*/}*.html'],
      css: ['<%= ocupado.dist %>/styles/{,*/}*.css'],
      options: {
        dirs: ['<%= ocupado.dist %>']
      }
    },
    uglify: {
      dist: {
        options: {
          mangle: false
        },
        files: [{
          expand: true,
          cwd: '<%= ocupado.dist %>/scripts',
          src: '**/*.js',
          dest: '<%= ocupado.dist %>/scripts/'
        }]
      },
      env: {
        options: {
          banner: "window._ENV='production';"
        },
        files: {
          '<%= ocupado.dist %>/scripts/main.js': ['<%= ocupado.dist %>/scripts/main.js']
        }
      }
    },
    htmlmin: {
      dist: {
        options: {
          /*removeCommentsFromCDATA: true,
          // https://github.com/ocupado/grunt-usemin/issues/44
          //collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          useShortDoctype: true,
          removeEmptyAttributes: true,
          removeOptionalTags: true*/
        },
        files: [{
          expand: true,
          cwd: '<%= ocupado.app %>',
          src: '*.html',
          dest: '<%= ocupado.dist %>'
        }]
      }
    },
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= ocupado.app %>',
          dest: '<%= ocupado.dist %>',
          src: [
            '*.{ico,txt}',
            'images/{,*/}*.*',
            'fonts/{,*/}*.*'
          ]
        },{
          dest: '<%= ocupado.dist %>/config.xml',
          src: ['dist/config.xml']
        }]
      }
    },
    handlebars: {
      compile: {
        files: {
          '.tmp/scripts/templates.js': ['app/scripts/**/*.hbs']
        },
        options: {
          namespace: 'Ocupado.Templates',
          wrapped: true,
          partialsUseNamespace: true
        }
      },
      test: {
        files: {
          'test/spec/templates.js': ['app/scripts/**/*.hbs']
        },
        options: {
          namespace: 'Ocupado.Templates',
          wrapped: true,
          partialsUseNamespace: true
        }
      }
    },
    rev: {
      dist: {
        files: {
          src: [
            '<%= ocupado.dist %>/scripts/{,*/}*.js',
            '<%= ocupado.dist %>/styles/{,*/}*.css'
          ]
        }
      }
    },
    shell: {
      android: {
        command: 'cordova run android',
        options: {
          stdout: true,
          execOptions: {
            cwd: '<%= ocupado.dist %>'
          }
        }
      },
      ios: {
        command: 'cordova build ios',
        options: {
          stdout: true,
          execOptions: {
            cwd: '<%= ocupado.dist %>'
          }
        }
      }
    }
  });

  grunt.registerTask('server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    if (target === 'test') {
      return grunt.task.run([
        'clean:server',
        'coffee',
        'handlebars',
        'watch:livereload'
      ]);
    }

    grunt.task.run([
      'clean:server',
      'coffee:dist',
      'stylus:compile',
      'handlebars',
      'connect:livereload',
      'watch'
      // 'watch:coffee',
      // 'watch:livereload',
      // 'watch:jst',
      // 'watch:stylus'
      // TODO: https://github.com/gruntjs/grunt-contrib-watch/issues/206
    ]);

  });

  grunt.registerTask('test', function(target){
    grunt.task.run([
      'clean:server',
      'coffee:test',
      'handlebars:test',
      'connect:test',
      'mocha',
      'watch:test'
    ]);
  });

  grunt.registerTask('build', function(target){
    grunt.task.run([
      'clean:dist',
      'coffee',
      'handlebars',
      'useminPrepare',
      'htmlmin',
      'concat',
      'stylus:compile',
      'uglify:dist',
      'uglify:env',
      'copy',
      'rev',
      'usemin',
      target ? 'shell:' + target : 'shell:ios'
    ]);
  });

  grunt.registerTask('default', [
    'jshint',
    'test',
    'build'
  ]);
};

