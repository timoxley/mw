hat = require 'hat'

store = require './store'

makeId = -> hat 128*4

module.exports = (store, key = 'sid') -> (req, res, next) ->
    throw new Error 'no cookies' unless req?.cookies?
    id = req.cookies[key]
    id ?= makeId()
    res.setHeader 'Set-Cookie', ["#{key}=#{id}"]

    origEnd = res.end
    res.end = (data, encoding) ->
        res.end = origEnd
        store.set id, req.session, ->
            res.end data, encoding

    store.get id, (err, session) ->
        throw new Error err if err?
        req.session = session
        next()

module.exports.store = store
