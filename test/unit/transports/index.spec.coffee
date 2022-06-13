describe 'Transports', ->
	When -> @Transport = importModule('src/transports').Transport

	describe '#Console', ->
		Then ->
			@Transport.Console.should.not.be.undefined
			@Transport.Console.should.be.a('function')
