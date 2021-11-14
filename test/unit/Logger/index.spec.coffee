describe 'config and create are exported', ->
  When -> @module = importModule('Logger')
  Then -> @module.createLogger.should.not.be.undefined
  And -> @module.LoggerConfig.should.not.be.undefined
