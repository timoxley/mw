redirect = require '../lib/redirect'

module.exports =
    simple: (test) ->
        toRoot = redirect '/'
        res =
            writeHead: (code, header) ->
                test.equal 302, code
                test.equal header.Location, '/'
            end: ->
                test.expect 2
                test.done()
        toRoot {}, res

    function: (test) ->
        middleware = redirect (req) -> req.foo
        req =
            foo: 'xxx'
        res =
            writeHead: (code, header) ->
                test.equal 302, code
                test.equal header.Location, 'xxx'
            end: ->
                test.expect 2
                test.done()
        middleware req, res

    permanent: (test) ->
        middleware = redirect '/', true
        res =
            writeHead: (code, header) ->
                test.equal 301, code
                test.equal header.Location, '/'
            end: ->
                test.expect 2
                test.done()
        middleware {}, res

    'two functions': (test) ->
        middleware = redirect (req) -> req.foo

        res0 = (next) ->
            writeHead: (code, header) -> test.equal header.Location, 0
            end: -> next()

        res1 =
            writeHead: (code, header) -> test.equal header.Location, 1
            end: -> test.done()

        middleware {foo: 0}, res0 ->
            middleware {foo: 1}, res1
