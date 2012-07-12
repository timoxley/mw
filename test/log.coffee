{log} = require '../lib'

module.exports =
    simple: (test) ->
        origLog = console.log
        console.log = (expected) ->
            test.equal 'hallo', expected
            console.log = origLog
            test.done()
        middleware = log 'hallo'
        middleware null, null, ->
    functional: (test) ->
        origLog = console.log
        console.log = (expected) ->
            test.equal 'bar', expected
            console.log = origLog
            test.done()
        middleware = log (req) -> req.foo
        middleware {foo: 'bar'}, null, ->
    arbitaryLogger: (test) ->
        console.foo = (expected) ->
            test.equal 'foo', expected
            test.done()
        middleware = log 'foo', 'foo'
        middleware null, null, ->

