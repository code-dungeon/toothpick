describe 'module', ->

  describe 'config and create are exported', ->
    When -> @module = importModule('src/index').Logger
    Then -> @module.create.should.not.be.undefined
    And -> @module.Config.should.not.be.undefined
    And -> @module.Format.should.not.be.undefined
    And -> @module.Transport.should.not.be.undefined

  describe 'create returns a logger', ->
    Given -> @module = importModule('src/index').Logger
    When -> @logger = @module.create()
    Then -> @logger.should.not.be.undefined
    And -> @logger.info.should.be.a('function')
    And -> @logger.warn.should.be.a('function')
    And -> @logger.error.should.be.a('function')

  describe 'createWithFilename returns a logger', ->
    Given -> @module = importModule('src/index').Logger
    When -> @logger = @module.createWithFilename(__filename)
    Then -> @logger.should.not.be.undefined
    And -> @logger.info.should.be.a('function')
    And -> @logger.warn.should.be.a('function')
    And -> @logger.error.should.be.a('function')

  describe 'createWithFilename returns a logger', ->
    Given -> @module = importModule('src/index').Logger
    When -> @logger = @module.createWithFilename('someFile')
    Then -> @logger.should.not.be.undefined
    And -> @logger.info.should.be.a('function')
    And -> @logger.warn.should.be.a('function')
    And -> @logger.error.should.be.a('function')
