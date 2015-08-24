global.sinon = require 'sinon'
global.chai = require 'chai'
global.expect = chai.expect
sinonChai = require 'sinon-chai'
chai.use(sinonChai)


# Require the components to test
require 'spec/reducers/article'
require 'spec/components/likebutton'
