describe 'config and create are exported', ->
  When -> @module = importModule('src/Logger')
  Then -> expect(@module.createLogger).to.not.be.undefined
  And -> expect(@module.LoggerConfig).to.not.be.undefined
