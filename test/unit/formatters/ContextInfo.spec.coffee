create = importModule('formatters/ContextInfo').createContextInfo
os = require('os')

describe 'ContextInfo', ->
	Given -> 
		@ctxData = {'correlation-id':'123'}
		@ctxCallback = stub().returns(@ctxData)
	When -> @result = @ContextInfo.transform(@info)

	describe 'missing getContextInfo', ->
		Given -> 
			@ContextInfo = create()
			@info = {}
		Then -> @result.should.not.be.undefined
		And -> @result.should.not.have.property('ctx')

	describe 'getContextInfo returns nothing', ->
		Given ->
			@ctxCallback = stub()
			@ContextInfo = create(@ctxCallback)
			@info = {}
		Then -> @result.should.not.be.undefined
		And -> @result.should.not.have.property('ctx')
		And -> @ctxCallback.should.have.been.calledWith(@info)

	describe 'default path', ->
		Given -> 
			@ContextInfo = create(@ctxCallback)
			@info = {}
		Then -> @result.ctx.should.not.be.undefined
		And -> @result.ctx.should.equal(@ctxData)
		And -> @ctxCallback.should.have.been.calledWith(@info)

	describe 'renamed path', ->
		Given ->
			@ContextInfo = create(@ctxCallback, 'ctxData')
			@info = {}
		Then -> @result.ctxData.should.not.be.undefined
		And -> @result.ctxData.should.equal(@ctxData)
		And -> @ctxCallback.should.have.been.calledWith(@info)

	describe 'renamed nested path', ->
		Given -> 
			@ContextInfo = create(@ctxCallback, 'ctx.data')
			@info = {}
		Then -> @result.ctx.should.not.be.undefined
		And -> @result.ctx.should.be.an('object')
		And -> @result.ctx.data.should.not.be.undefined
		And -> @result.ctx.data.should.equal(@ctxData)
		And -> @ctxCallback.should.have.been.calledWith(@info)

	describe 'existing nested path', ->
		Given -> 
			@ContextInfo = create(@ctxCallback, 'ctx.data')
			@info = {ctx:{previous:'untouched'}}
		Then -> @result.ctx.should.not.be.undefined
		And -> @result.ctx.should.be.an('object')
		And -> @result.ctx.data.should.not.be.undefined
		And -> @result.ctx.data.should.equal(@ctxData)
		And -> @result.ctx.previous.should.not.be.undefined
		And -> @result.ctx.previous.should.equal('untouched')
		And -> @ctxCallback.should.have.been.calledWith(@info)
