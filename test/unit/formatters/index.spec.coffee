describe 'Format', ->
  When -> @Format = importModule('formatters').Format
  
  Then '#align', -> @Format.align.should.not.be.undefined
  And -> @Format.align.should.be.a('function')
    
  Then '#appname', -> @Format.appname.should.not.be.undefined
  And -> @Format.appname.should.be.a('function')

  Then '#cli', -> @Format.cli.should.not.be.undefined
  And -> @Format.cli.should.be.a('function')

  Then '#colorize', -> @Format.colorize.should.not.be.undefined
  And -> @Format.colorize.should.be.a('function')

  Then '#combine', -> @Format.combine.should.not.be.undefined
  And -> @Format.combine.should.be.a('function')

  Then '#context', -> @Format.context.should.not.be.undefined
  And -> @Format.context.should.be.a('function')

  Then '#format', -> @Format.format.should.not.be.undefined
  And -> @Format.format.should.be.a('function')

  Then '#hostname', -> @Format.hostname.should.not.be.undefined
  And -> @Format.hostname.should.be.a('function')

  Then '#json', -> @Format.json.should.not.be.undefined
  And -> @Format.json.should.be.a('function')

  Then '#label', -> @Format.label.should.not.be.undefined
  And -> @Format.label.should.be.a('function')

  Then '#logstash', -> @Format.logstash.should.not.be.undefined
  And -> @Format.logstash.should.be.a('function')

  Then '#metadata', -> @Format.metadata.should.not.be.undefined
  And -> @Format.metadata.should.be.a('function')

  Then '#ms', -> @Format.ms.should.not.be.undefined
  And -> @Format.ms.should.be.a('function')

  Then '#padLevels', -> @Format.padLevels.should.not.be.undefined
  And -> @Format.padLevels.should.be.a('function')

  Then '#pid', -> @Format.pid.should.not.be.undefined
  And -> @Format.pid.should.be.a('function')

  Then '#prettyErrors', -> @Format.prettyErrors.should.not.be.undefined
  And -> @Format.prettyErrors.should.be.a('function')

  Then '#prettyPrint', -> @Format.prettyPrint.should.not.be.undefined
  And -> @Format.prettyPrint.should.be.a('function')

  Then '#printf', -> @Format.printf.should.not.be.undefined
  And -> @Format.printf.should.be.a('function')

  Then '#simple', -> @Format.simple.should.not.be.undefined
  And -> @Format.simple.should.be.a('function')

  Then '#splat', -> @Format.splat.should.not.be.undefined
  And -> @Format.splat.should.be.a('function')

  Then '#timestamp', -> @Format.timestamp.should.not.be.undefined
  And -> @Format.timestamp.should.be.a('function')

  Then '#uncolorize', -> @Format.uncolorize.should.not.be.undefined
  And -> @Format.uncolorize.should.be.a('function')
