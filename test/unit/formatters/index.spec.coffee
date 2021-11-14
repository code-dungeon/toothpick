describe 'Format', ->
  When -> @Format = importModule('formatters').Format
  
  Then '#align', -> @Format.align.should.not.be.undefined
  And -> @Format.align.should.be.a('function')
    
  Then '#appname', -> @Format.appname.should.not.be.undefined
  And -> @Format.appname.should.be.a('function')

  Then '#combine', -> @Format.combine.should.not.be.undefined
  And -> @Format.combine.should.be.a('function')

  Then '#format', -> @Format.format.should.not.be.undefined
  And -> @Format.format.should.be.a('function')

  Then '#hostname', -> @Format.hostname.should.not.be.undefined
  And -> @Format.hostname.should.be.a('function')

  Then '#json', -> @Format.json.should.not.be.undefined
  And -> @Format.json.should.be.a('function')

  Then '#label', -> @Format.label.should.not.be.undefined
  And -> @Format.label.should.be.a('function')

  Then '#metadata', -> @Format.metadata.should.not.be.undefined
  And -> @Format.metadata.should.be.a('function')

  Then '#pid', -> @Format.pid.should.not.be.undefined
  And -> @Format.pid.should.be.a('function')

  Then '#prettyPrint', -> @Format.prettyPrint.should.not.be.undefined
  And -> @Format.prettyPrint.should.be.a('function')

  Then '#printf', -> @Format.printf.should.not.be.undefined
  And -> @Format.printf.should.be.a('function')

  Then '#splat', -> @Format.splat.should.not.be.undefined
  And -> @Format.splat.should.be.a('function')

  Then '#timestamp', -> @Format.timestamp.should.not.be.undefined
  And -> @Format.timestamp.should.be.a('function')

  Then '#context', -> @Format.context.should.not.be.undefined
  And -> @Format.context.should.be.a('function')
