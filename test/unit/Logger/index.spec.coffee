describe 'config and create are exported', ->
  When -> @module = importModule('Logger')
  Then -> expect(@module.createLogger).to.not.be.undefined
  And -> expect(@module.LoggerConfig).to.not.be.undefined
