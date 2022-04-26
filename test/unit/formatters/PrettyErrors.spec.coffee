create = importModule('formatters/PrettyErrors').createPrettyErrors

describe 'PrettyErrors', ->
  When -> @result = @prettyErrors.transform(@info)

  describe 'no log', ->
    Given ->
      @info = null
      @prettyErrors = create()
    Then -> expect(@result).to.eql(null)

  describe 'no error', ->
    Given ->
      @info = { message: 'something' }
      @prettyErrors = create()
    Then -> @result.should.eql({ message: 'something' })
    And 'doesn\'t mutate original', -> @info.should.not.equal(@result)

  describe 'circular object', ->
    Given ->
      @info = { message: 'something' }
      @info.info = @info
      @prettyErrors = create()
    Then -> @result.message.should.eql('something')

  describe 'no keys', ->
    Given ->
      @info = 1
      @info.info = @info
      @prettyErrors = create()
    Then -> @result.should.eql(1)

  describe 'array', ->
    Given ->
      @info = { message: 'something', values: [new Error('something bad happened.')] }
      @info.info = @info
      @prettyErrors = create()
    Then -> @result.message.should.eql('something')
    And -> @result.values[0].errorType.should.equal('Error')
    And -> @result.values[0].message.should.equal('something bad happened.')

  describe 'has error', ->
    describe 'top level', ->
      Given ->
        @info = new Error('something bad happened.')
        @prettyErrors = create({ stack: true })
      Then -> @result.message.should.equal('something bad happened.')
      And -> @result.errorType.should.equal('Error')
      And -> @result.stack.should.be.an('Array')

    describe 'nested', ->
      Given -> @info = { message: 'something', nested: { error: new TypeError('bad happened') } }

      describe 'without add stack', ->
        Given -> @prettyErrors = create()
        Then -> @result.message.should.equal('something')
        And -> @result.nested.error.errorType.should.equal('TypeError')
        And -> @result.nested.error.message.should.equal('bad happened')

      describe 'with add stack', ->
        Given -> @prettyErrors = create({ stack: true })
        Then -> @result.message.should.equal('something')
        And -> @result.nested.error.errorType.should.equal('TypeError')
        And -> @result.nested.error.message.should.equal('bad happened')
        And -> @result.nested.error.stack.should.be.an('Array')
