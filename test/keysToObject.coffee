{keysToObject} = require '../lib/utility'

module.exports =
    empty: (test) ->
        test.equal true, keysToObject [], true
        test.done()
    single: (test) ->
        test.deepEqual {foo: true}, keysToObject ['foo'], true
        test.done()
    several: (test) ->
        test.deepEqual {foo: bar: baz: true}, keysToObject ['foo', 'bar', 'baz'], true
        test.done()
