path = require('path')
chai = require('chai')
chaiProperties = require('chai-properties')
chaiAsPromised = require("chai-as-promised")
sinon = require('sinon')
sinonChai = require('sinon-chai')

global.importModule = (srcPath) ->
  modulePath = path.join(process.cwd(), srcPath)
  return require(modulePath)

global.projRoot = path.join(process.cwd(), 'server')

global.createCallback = (obj, done) ->
  (error, results) ->
    obj.error = error
    obj.results = results
    done()

global.sinon = sinon
global.spy = sinon.spy
global.stub = sinon.stub
global.mock = sinon.mock
global.sandbox = sinon.sandbox
global.assert = sinon.assert.expose(chai.assert, { prefix: "" })

chai.config.includeStack = true
chai.config.truncateThreshold = 0
chai.config.showDiff = true

global.assert = chai.assert
global.expect = chai.expect
global.should = chai.should()

chai.use(sinonChai)
chai.use(chaiProperties)
chai.use(chaiAsPromised)

process.on('unhandledRejection', () ->)
