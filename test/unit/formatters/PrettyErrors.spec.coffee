create = importModule('src/formatters/PrettyErrors').createPrettyErrors

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

  describe 'has function', ->
    Given ->
      @info = { message: 'something', func: -> }
      @prettyErrors = create()
    Then -> expect(@result.func).to.be.undefined

  describe 'has toJSON', ->
    describe 'returns', ->
      Given ->
        @info = { message: 'something', toJSON: -> 'else' }
        @prettyErrors = create()
      Then -> @result.should.equal('else')
    describe 'throws error', ->
      Given ->
        @info = { message: 'something', toJSON: -> throw new RangeError('some error') }
        @prettyErrors = create()
      Then -> @result.should.eql({ errorType: 'RangeError', message: 'some error' })


  describe 'has no keys', ->
    Given ->
      @info = { message: 'something', nested: {} }
      @prettyErrors = create()
    Then -> @result.message.should.equal('something')
    And -> expect(@result.nested).to.be.undefined

  describe 'getter throw returns pretty error', ->
    Given ->
      @info = { something: 'works' }
      Object.defineProperties(@info, { somekey: { enumerable: true, get: ->
        throw new TypeError('dang')
        } })
      @prettyErrors = create()
    Then -> @result.something.should.equal('works')
    And -> @result.somekey.should.eql({ errorType: 'TypeError', message: 'dang' })

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
