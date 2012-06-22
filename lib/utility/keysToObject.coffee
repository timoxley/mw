toObject = (key, value) ->
    obj = {}
    obj[key] = value
    obj

module.exports = (keys, value) ->
    if keys.length is 0 then return value
    [heads..., last] = keys
    module.exports heads, toObject last, value
