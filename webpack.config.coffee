path = require 'path'
webpack = require 'webpack'

module.exports =
  cache: true
  watch: true
  entry: [
    'webpack-dev-server/client?http://localhost:3000' # still needed?
    'webpack/hot/dev-server'
    path.join __dirname, 'app/scripts/main'
  ]
  output:
    path: path.join __dirname, '.tmp/scripts'
    publicPath: 'scripts'
    filename: 'main.min.js'
  resolveLoader:
    modulesDirectories: ['node_modules']
  resolve:
    root: [
      path.join __dirname, 'app/scripts'
      path.join __dirname, 'app/styles'
    ]
    extensions: ['', '.js', '.cjsx', '.coffee']
  module:
    loaders: [
      {
        test: /\.sass$/,
        loader: 'style!css!sass?indentedSyntax&includePaths[]=' +
          (path.resolve(__dirname, "./app/styles"))
      },
      { test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx']},
      { test: /\.coffee$/, loader: 'coffee' }
    ]
  plugins: [
    new webpack.HotModuleReplacementPlugin()
    new webpack.NoErrorsPlugin()
  ]
