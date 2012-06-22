isFunction = (obj) -> '[object Function]' is toString.call obj

permCode = 301
tempCode = 302

module.exports = (location, permanent = false) -> (req, res) ->
    statusCode = if permanent then permCode else tempCode
    location = location req if  isFunction location
    location = if location is 'back' then req.url else location
    console.log "redirect to #{location}"
    res.writeHead statusCode, {Location: location}
    res.end()
