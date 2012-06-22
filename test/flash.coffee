flash = require '../lib/flash'

module.exports =
    'simple': (test) ->
        f = flash 'test', 'type'
        req =
            session: {}
        next = ->
            test.equal 'test', req.session.flash.message
            test.equal 'type', req.session.flash.type
            test.done()
        f req, null, next
    'functional': (test) ->
        f = flash (req) -> req.foo
        req =
            session: {}
            foo: 'bar'
        next = ->
            test.equal 'bar', req.session.flash.message
            test.done()
        f req, null, next

