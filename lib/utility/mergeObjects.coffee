_ = require 'underscore'

isObject = (obj) -> obj is Object obj

module.exports = merge = (o1, o2) ->
    result = _.clone o1
    return o2 unless isObject o2
    _.each o2, (value, key) ->
        return result[key] = value unless result[key]?
        return result[key] = value unless isObject result[key]
        result[key] = merge result[key], value
    result
