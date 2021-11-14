describe 'LoggerConfig', ->
  Given -> @LoggerConfig = importModule('Logger/LoggerConfig').LoggerConfig
  
  describe 'defaults', ->
    When -> @Config = new @LoggerConfig()

    Then '.silent', -> @Config.silent.should.be.false
    
    Then '.formats', -> @Config.formats.should.not.be.undefined
    And -> @Config.formats.should.be.an('Array')
    And -> @Config.formats.should.have.lengthOf(6)
    
    Then '.transports', -> @Config.transports.should.not.be.undefined
    And -> @Config.transports.should.be.an('Array')
    And -> @Config.transports.should.have.lengthOf(1)
