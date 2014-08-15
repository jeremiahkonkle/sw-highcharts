require('coffee-script/register');

var gulp = require('gulp');

var serve_path = "./build"
var script_entry = './src/app.coffee'
var build_dir = './build'
var static_src = './src/static/**/*'
var static_dest = './build/static'

gulp.task('dev', ['livereload', 'watch-static']);

gulp.task('livereload', ['serve'], function() {
  var livereload = require('gulp-livereload');
  var server = livereload();
  gulp.watch('build/**').on('change', function(file) {
      server.changed(file.path);
  });
});

gulp.task('serve', ['watchify'], function() {
  var connect = require('connect');
  var logger = require('morgan');
  var serveStatic = require('serve-static');

  var http = require('http');
  
	var app = connect()
		.use(logger('dev'))
		.use(serveStatic(serve_path));
    
	http.createServer(app).listen(8080);
});

gulp.task('watchify', function() {
  var watchify = require('watchify');
  var source = require('vinyl-source-stream');
  var gutil = require('gulp-util');
  var notify = require('gulp-notify');
  
  var bundler = watchify({entries: script_entry, extensions: ['.coffee']});
  //var bundler = watchify({entries: './src/app.coffee'});

  function rebundle () {
    return bundler.bundle({debug: true})
      //.on("error", notify.onError("Bundling Error: <%= error.message %>"))
      .on('error', gutil.log)
      .pipe(source('bundle.js'))
      .pipe(gulp.dest(build_dir))
      //.pipe(notify("Rebundle Complete"))
  }

  bundler.on('update', rebundle);

  return rebundle();
});

gulp.task('copy-static', function() {
  gulp.src(static_src)
    .pipe(gulp.dest(static_dest));
  
  gulp.src('./src/index.html')
    .pipe(gulp.dest(build_dir));  
});

gulp.task('watch-static', ['copy-static'], function() {
  gulp.watch('./src/index.html', ['copy-static']);
  gulp.watch(static_src, ['copy-static']);
});


gulp.task('mocha', function() {
  var mocha = require('gulp-mocha');
  
  return gulp.src(['src/javascript/*/*.mocha.js', 'src/javascript/*/*.mocha.coffee'], { read: false })
    .pipe(mocha({
      reporter: 'spec',
      globals: {
        should: require('should')
      }
    }));
});

gulp.task('mocha-simple', function() {
  var mocha = require('gulp-mocha');
  var gutil = require('gulp-util');
  
  return gulp.src(['src/javascript/*/*.mocha.js'], { read: false })
    .pipe(mocha({
      reporter: 'dot',
      globals: {
        should: require('should')
      }
    }))
    .on('error', gutil.log);
});

gulp.task('mocha-watch', function() {
    gulp.watch(['src/javascript/**'], ['mocha-simple']);
});