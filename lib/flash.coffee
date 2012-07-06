isFunction = (obj) -> '[object Function]' is toString.call obj

module.exports = (message, type = 'info') -> (req, res, next) ->
    throw new Error 'missing session middleware' unless req?.session?
    throw new Error "next is not a function #{next}" unless isFunction next
    msg = message
    msg = msg req if isFunction msg
    console.log 'flash', type, msg
    req.session.flash =
        message: msg
        type: type
    next()
