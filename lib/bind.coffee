{deepSet} = require './utility'
error = require './error-middleware'

module.exports = bind = (name, f) -> (req, res, next) ->
    f req, (err, result) ->
        return error req, res, err, name if err?
        req.loaded = deepSet req.loaded || {}, name.split('.'), result
        next()
