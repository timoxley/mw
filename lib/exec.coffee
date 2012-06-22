error = require './error-middleware'

module.exports = exec = (f) -> (req, res, next) ->
    f req, (err, result) ->
        if err? then return error req, res
        next()
