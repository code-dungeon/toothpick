module = importModule('Logger/Logger')
create = module.createLogger
LoggerConfig = importModule('Logger/LoggerConfig').LoggerConfig

describe 'Logger', ->
  Given -> @Config = new LoggerConfig()
  When -> @logger = create(@Config, @opts)

  describe 'defaults', ->
    Given -> @opts = {}  
    Then -> @logger.should.not.be.undefined
    And -> @logger.info.should.be.a('function')
    And -> @logger.warn.should.be.a('function')
    And -> @logger.error.should.be.a('function')

  describe 'with name', ->
    Given -> @opts = {name:'test'}
    Then -> @logger.should.not.be.undefined
    And -> @logger.info.should.be.a('function')
    And -> @logger.warn.should.be.a('function')
    And -> @logger.error.should.be.a('function')

  describe 'with name and path overwritten', ->
    Given -> @opts = {name:'test', namePath: 'app.name'}
    Then -> @logger.should.not.be.undefined
    And -> @logger.info.should.be.a('function')
    And -> @logger.warn.should.be.a('function')
    And -> @logger.error.should.be.a('function')
