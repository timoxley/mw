isFunction = (obj) -> '[object Function]' is toString.call obj

permCode = 301
tempCode = 302

module.exports = (location, permanent = false) -> (req, res) ->
    statusCode = if permanent then permCode else tempCode
    loc = location
    loc = loc req if  isFunction loc
    loc = if loc is 'back' then req.url else loc
    console.log "redirect to #{loc}"
    res.writeHead statusCode, {Location: loc}
    res.end()
