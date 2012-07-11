module.exports = ->
    sessions = {}
    get: (id, next) ->
        result = {}
        result = JSON.parse sessions[id] if sessions[id]?
        next null, result
    set: (id, session, next) ->
        sessions[id] = JSON.stringify session
        next()
