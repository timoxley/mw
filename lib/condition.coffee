isFunction = (obj) -> '[object Function]' is toString.call obj

nop = (req, res, next) -> next()
module.exports = (test, left, right = nop) ->
    throw new Error 'test is not a function' unless isFunction test
    throw new Error 'first middleware is not a function' unless isFunction left
    throw new Error 'second middleware is not a function' unless isFunction right
    (req, res, next) -> (if test req then left else right) req, res, next

