error = require './error-middleware'

module.exports = exec = (f) -> (req, res, next) ->
    f req, (err, result) ->
        return error req, res, err, 'exec' if err?
        next()
