# Wrapping JsDom because of:
# https://github.com/facebook/react/issues/1445 and
# https://github.com/webpack/webpack/issues/718
JsDom = require 'jsdom'

global.document = JsDom.jsdom \
  '<!DOCTYPE html><html><head></head><body></body></html>'
global.window = document.defaultView
global.navigator = window.navigator

require('./main.js')
