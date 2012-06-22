isFunction = (obj) -> '[object Function]' is toString.call obj

module.exports = (message, type = 'info') -> (req, res, next) ->
    throw new Error 'missing session middleware' unless req?.session?
    throw new Error "next is not a function #{next}" unless isFunction next
    message = message req if isFunction message
    console.log 'flash', type, message
    req.session.flash =
        message: message
        type: type
    next()
