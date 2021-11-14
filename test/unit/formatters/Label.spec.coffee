create = importModule('formatters/Label').createLabel
os = require('os')

describe 'Label', ->
	Given -> @value = 'some value'
	When -> @result = @label.transform(@info)

	describe 'top level path', ->
		Given -> 
			@label = create(@value, 'label')
			@info = {}
		Then -> @result.label.should.not.be.undefined
		And -> @result.label.should.equal(@value)

	describe 'nested path', ->
		Given -> 
			@label = create(@value, 'label.nested')
			@info = {}
		Then -> @result.label.should.not.be.undefined
		And -> @result.label.should.be.an('object')
		And -> @result.label.nested.should.not.be.undefined
		And -> @result.label.nested.should.equal(@value)

	describe 'existing nested path', ->
		Given -> 
			@label = create(@value, 'label.nested')
			@info = {label:{previous:'untouched'}}
		Then -> @result.label.should.not.be.undefined
		And -> @result.label.should.be.an('object')
		And -> @result.label.nested.should.not.be.undefined
		And -> @result.label.nested.should.equal(@value)
		And -> @result.label.previous.should.not.be.undefined
		And -> @result.label.previous.should.equal('untouched')
