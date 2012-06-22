assert = require 'assert'

isFunction = (obj) -> '[object Function]' is toString.call obj


module.exports = (view) ->
    assert isFunction(view), 'middleware.render: missing view'
    (req, res, next) ->
        loaded = req.loaded || {}
        console.info 'rendering view with', Object.keys(loaded)
        res.writeHead 200, 'Content-Type': 'text/html; charset=utf-8'
        res.end view loaded
