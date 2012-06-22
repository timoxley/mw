exec = require '../lib/exec'

module.exports =
    'simple': (test) ->
        f = -> test.done()
        exec(f) {}, {}, ->
    'is continuing': (test) ->
        f = (req, next) -> next()
        exec(f) {}, {}, -> test.done()
    'error handling': (test) ->
        f = (req, next) -> next 'ERROR'
        res =
            writeHead: (status) -> test.equals 500, status
            end: -> test.done()
        exec(f) {}, res, ->
