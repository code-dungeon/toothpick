create = importModule('formatters/Pid').createPid
os = require('os')

describe 'Pid', ->
	Given -> @processId = process.pid
	When -> @result = @pid.transform(@info)

	describe 'default path', ->
		Given -> 
			@pid = create()
			@info = {}
		Then ->  @result.pid.should.not.be.undefined
		And -> @result.pid.should.equal(@processId)

	describe 'renamed path', ->
		Given -> 
			@pid = create('process')
			@info = {}
		Then -> @result.process.should.not.be.undefined
		And -> @result.process.should.equal(@processId)

	describe 'renamed nested path', ->
		Given -> 
			@pid = create('process.id')
			@info = {}
		Then -> @result.process.should.not.be.undefined
		And -> @result.process.should.be.an('object')
		And -> @result.process.id.should.not.be.undefined
		And -> @result.process.id.should.equal(@processId)

	describe 'existing nested path', ->
		Given -> 
			@pid = create('process.id')
			@info = {process:{previous:'untouched'}}
		Then -> @result.process.should.not.be.undefined
		And -> @result.process.should.be.an('object')
		And -> @result.process.id.should.not.be.undefined
		And -> @result.process.id.should.equal(@processId)
		And -> @result.process.previous.should.not.be.undefined
		And -> @result.process.previous.should.equal('untouched')
