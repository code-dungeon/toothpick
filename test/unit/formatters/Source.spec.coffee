# create = importModule('formatters/Source').source
# os = require('os')

# describe 'Source', ->
#   Given -> @name = 'node_modules/mocha/lib/runnable'
#   When -> @result = @source.transform(@info)

#   describe 'default path', ->
#     Given -> 
#       @source = create()
#       @info = {}
#     Then -> @result.source.should.not.be.undefined
#     And -> @result.source.should.equal(@name)
  
#   describe 'renamed path', ->
#     Given -> 
#       @source = create('class')
#       @info = {}
#     Then -> @result.class.should.not.be.undefined
#     And -> @result.class.should.equal(@name)

#   describe 'renamed nested path', ->
#     Given -> 
#       @source = create('class.source')
#       @info = {}
#     Then -> @result.class.should.not.be.undefined
#     And -> @result.class.should.be.an('object')
#     And -> @result.class.source.should.not.be.undefined
#     And -> @result.class.source.should.equal(@name)

#   describe 'existing nested path', ->
#     Given -> 
#       @source = create('class.source')
#       @info = {class:{previous:'untouched'}}
#     Then -> @result.class.should.not.be.undefined
#     And -> @result.class.should.be.an('object')
#     And -> @result.class.source.should.not.be.undefined
#     And -> @result.class.source.should.equal(@name)
#     And -> @result.class.previous.should.not.be.undefined
#     And -> @result.class.previous.should.equal('untouched')
