gulp = require 'gulp'
gutil = require 'gulp-util'
$ = require('gulp-load-plugins')()
path = require 'path'

webpackConfig = require('./webpack.config')
webpack = require('webpack')
WebpackDevServer = require('webpack-dev-server')

gulp.task 'default', [ 'clean' ], -> gulp.start 'serve'

# TODO: split up tasks in separate files

gulp.task 'serve', [
  'copy-assets'
  'webpack-dev-server'
], ->


gulp.task 'clean', require('del').bind(null, [
  '.tmp'
])

gulp.task 'copy-assets', ->
  gulp.src([
      'app/index.html'
      'fixtures/article.json'
      'app/images/deepdream.jpg'
    ])
    .pipe(gulp.dest('.tmp'))

gulp.task 'webpack-dev-server', (done) ->
  compiler = webpack(webpackConfig)

  server = new WebpackDevServer compiler,
    contentBase: '.tmp'
    hot: true

  server.listen '3000', 'localhost', (err) ->
    throw new gutil.pluginerror("webpack-dev-server", err) if err

    gutil.log '[webpack-dev-server]', 'http://localhost:3000'
    done()


gulp.task 'test', ->
  gulp.src('./test/setup.coffee')
    .pipe($.coffee({ bare: true }))
    .pipe(gulp.dest('.tmp/test'))

  # FIXME: Make DRY by re-using webpack config
  webpackTestConfig =
    entry: [
      'main.coffee'
    ]
    target: 'node'
    output:
      path: path.join __dirname, '.tmp/test'
      filename: 'main.js'
    resolveLoader:
      modulesDirectories: ['node_modules']
    resolve:
      root: [
        path.join __dirname, 'app/scripts'
        path.join __dirname, 'test'
      ]
      extensions: ['', '.js', '.cjsx', '.coffee']
    module:
      loaders: [
        { test: /\.cjsx$/, loaders: ['coffee', 'cjsx'] },
        { test: /\.coffee$/, loader: 'coffee' }
      ]


  webpack(webpackTestConfig).run (err, stats) ->
    gulp.src('.tmp/test/setup.js')
      .pipe $.mocha({reporter:'nyan'})

