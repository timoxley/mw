mohair = require 'mohair'

module.exports = (mysql, table = 'session') ->
    get: (id, next) ->
        m = mohair()
        m.select table, ['session'], {id: id}
        mysql.query m.sql(), m.params(), (err, results) ->
            return next err if err?
            return next null, {} if results.length is 0
            [first] = results
            result = {}
            result = JSON.parse first.session if first?.session?
            next null, result
    set: (id, session, next) ->
        m = mohair()
        stringified = JSON.stringify session
        m.insert table, {id: id, session: stringified}, {session: stringified}
        mysql.query m.sql(), m.params(), next
