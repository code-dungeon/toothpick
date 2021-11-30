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
      @info = {message: 'something'}
      @prettyErrors = create() 
    Then -> @result.should.eql({message: 'something'})

  describe 'has error', ->
    Given -> @info = { message: 'something', nested: { error: new TypeError('bad happened') }}
    
    describe 'no stack', ->
      Given -> @prettyErrors = create()
      Then -> @result.message.should.equal('something')
      And -> @result.nested.error.errorType.should.equal('TypeError')
      And -> @result.nested.error.message.should.equal('bad happened')

    describe 'stack', ->
      Given -> @prettyErrors = create({stack:true})
      Then -> @result.message.should.equal('something')
      And -> @result.nested.error.errorType.should.equal('TypeError')
      And -> @result.nested.error.message.should.equal('bad happened')
      And -> @result.stack.should.be.an('Array')

    describe 'stack in custom location', ->
      Given -> @prettyErrors = create({stack:true, path: 'stack.values'})
      Then -> @result.message.should.equal('something')
      And -> @result.nested.error.errorType.should.equal('TypeError')
      And -> @result.nested.error.message.should.equal('bad happened')
      And -> @result.stack.values.should.be.an('Array')
