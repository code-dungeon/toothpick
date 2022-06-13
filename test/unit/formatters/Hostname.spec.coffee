create = importModule('src/formatters/Hostname').createHostname
os = require('os')

describe 'Hostname', ->
	Given -> @name = os.hostname()
	When -> @result = @hostname.transform(@info)

	describe 'default path', ->
		Given ->
			@hostname = create()
			@info = {}
		Then -> @result.hostname.should.not.be.undefined
		And -> @result.hostname.should.equal(@name)

	describe 'renamed path', ->
		Given ->
			@hostname = create('host')
			@info = {}
		Then -> @result.host.should.not.be.undefined
		And -> @result.host.should.equal(@name)

	describe 'renamed nested path', ->
		Given ->
			@hostname = create('host.hostname')
			@info = {}
		Then -> @result.host.should.not.be.undefined
		And -> @result.host.should.be.an('object')
		And -> @result.host.hostname.should.not.be.undefined
		And -> @result.host.hostname.should.equal(@name)

	describe 'existing nested path', ->
		Given ->
			@hostname = create('host.hostname')
			@info = {host:{previous:'untouched'}}
		Then ->  @result.host.should.not.be.undefined
		And -> @result.host.should.be.an('object')
		And -> @result.host.hostname.should.not.be.undefined
		And -> @result.host.hostname.should.equal(@name)
		And -> @result.host.previous.should.not.be.undefined
		And -> @result.host.previous.should.equal('untouched')
