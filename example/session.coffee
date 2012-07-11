http = require 'http'

sequenz = require 'sequenz'
{cookieParser} = require 'connect'

session = require '../lib/session'

srv = http.createServer sequenz [
    cookieParser()
    session()
    (req, res, next) -> next console.log req.session
    (req, res, next) ->
        req.session.foo ?= 0
        req.session.foo++
        next()
    (req, res, next) -> res.end "your count is #{req.session.foo}"

]

srv.listen 9191
