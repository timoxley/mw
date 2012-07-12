isFunction = (obj) -> '[object Function]' is toString.call obj

module.exports = (msg, type = 'log') -> (req, res, next) ->
    m = msg
    m = msg req if isFunction msg
    next console[type] m
