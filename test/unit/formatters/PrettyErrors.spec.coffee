create = importModule('src/formatters/PrettyErrors').createPrettyErrors

describe 'PrettyErrors', ->
  Given -> @info = { message: null }
  When -> @result = @prettyErrors.transform(@info)

  describe 'no error', ->
    Given ->
      @info.message = 'something'
      @prettyErrors = create()
    Then -> @result.should.eql({ message: 'something' })

  describe 'has function', ->
    Given ->
      @info.message = { k: 'something', func: -> }
      @prettyErrors = create()
    Then -> expect(@result.message.func).to.be.undefined

  describe 'has toJSON', ->
    describe 'returns', ->
      Given ->
        @info.message = { k: 'something', toJSON: -> 'else' }
        @prettyErrors = create()
      Then -> @result.message.should.equal('else')

    describe 'throws error', ->
      Given ->
        @info.message = { k: 'something', toJSON: -> throw new RangeError('some error') }
        @prettyErrors = create()
      Then -> @result.message.should.eql({
        errorType: 'RangeError'
        message: 'some error'
      })

  describe 'has no keys maintains instance', ->
    Given ->
      @nested = {}
      @info.message =  { k: 'something', nested: @nested }
      @prettyErrors = create()
    Then -> @result.message.should.eql({
      k: 'something'
      nested: @nested
    })
    And -> @result.message.nested.should.equal(@nested)

  describe 'getter throw returns pretty error', ->
    Given ->
      @info.message = { something: 'works' }
      Object.defineProperties(@info.message, { somekey: { enumerable: true, get: ->
        throw new TypeError('dang')
        } })
      @prettyErrors = create()
    Then -> @result.message.something.should.equal('works')
    And -> @result.message.somekey.should.eql({
      errorType: 'TypeError'
      message: 'dang'
    })

  describe 'has error', ->
    describe 'top level', ->
      Given ->
        @info.message = new RangeError('something bad happened.')
        @prettyErrors = create({ stack: true })
      Then -> @result.message.should.have.properties({
        message: 'something bad happened.'
        errorType: 'RangeError'
      })
      And -> @result.message.stack.should.be.an('Array')

  describe 'has array', ->
    describe 'plain array', ->
      Given ->
        @info.message = ['a', 'b', 'c']
        @prettyErrors = create()
      Then -> @result.message.should.eql(['a', 'b', 'c'])

    describe 'recursive array', ->
      Given ->
        @something = new Error('something')
        @info.message = { something: @something, arr: ['a', 'b', 'c', @something ] }
        @prettyErrors = create()
      Then -> @result.message.something.should.eql({ message: 'something', errorType: 'Error' })
      And -> @result.message.arr.length.should.equal(4)
      And -> @result.message.something.should.equal(@result.message.arr[3])
