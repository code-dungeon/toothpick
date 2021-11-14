create = importModule('formatters/Appname').createAppname

describe 'Appname', ->
	Given -> @name = '@code-dungeon/toothpick'
	When -> @result = @appname.transform(@info)

	describe 'default path', ->
		Given ->  
			@appname = create()
			@info = {}
		Then -> @result.app.should.not.be.undefined
		And -> @result.app.should.equal(@name)

	describe 'renamed path', ->
		Given -> 
			@appname = create('appname')
			@info = {}
		Then -> @result.appname.should.not.be.undefined
		And -> @result.appname.should.equal(@name)

	describe 'renamed nested path', ->
		Given -> 
			@appname = create('app.name')
			@info = {}
		Then -> @result.app.should.not.be.undefined
		And -> @result.app.should.be.an('object')
		And -> @result.app.name.should.not.be.undefined
		And -> @result.app.name.should.equal(@name)

	describe 'existing nested path', ->
		Given -> 
			@appname = create('app.name')
			@info = {app:{previous:'untouched'}}
		Then ->  @result.app.should.not.be.undefined
		And -> @result.app.should.be.an('object')
		And -> @result.app.name.should.not.be.undefined
		And -> @result.app.name.should.equal(@name)
		And -> @result.app.previous.should.not.be.undefined
		And -> @result.app.previous.should.equal('untouched')
