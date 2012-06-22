keysToObject = require './keysToObject'
mergeObjects = require './mergeObjects'

module.exports = deepSet = (obj, keys, value) ->
    mergeObjects obj, keysToObject keys, value
