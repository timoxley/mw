render = require '../lib/render'

global.console.info = ->

empty = -> ''


module.exports =
    'throws without a view': (test) ->
        test.throws -> render null
        test.throws -> render {}
        test.done()
    'view output': (test) ->
        hello = -> 'hello'
        middleware = render hello
        res =
            writeHead: ->
            end: (output) ->
                test.equal output, 'hello'
                test.done()
        middleware {}, res
    'view with variables': (test) ->
        view = (params) ->
            test.equal params.a, 'string'
            test.equal params.b, 5
            test.done()
        middleware = render view
        res =
            writeHead: ->
            end: ->
        middleware {loaded: {a: 'string', b: 5}}, res
