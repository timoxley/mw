module.exports = (req, res, next) ->
    hasFlash = req?.session?.flash?
    makeAvailable = () ->
        req.loaded ?= {}
        req.loaded.flash = req.session.flash
        console.log 'show flash', req.loaded.flash
        delete req.session.flash
    makeAvailable() if hasFlash
    next()
