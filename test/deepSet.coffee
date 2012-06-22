{deepSet} = require '../lib/utility'

module.exports =
    'empty': (test) ->
        test.deepEqual 'literal', deepSet {}, [], 'literal'
        test.done()
    'simple': (test) ->
        test.deepEqual {foo: 'bar'}, deepSet {}, ['foo'], 'bar'
        test.done()
    'nested': (test) ->
        test.deepEqual {foo: bar: 'baz'}, deepSet {}, ['foo', 'bar'], 'baz'
        test.done()
    'preserve old value': (test) ->
        test.deepEqual {old: true, new: true}, deepSet {old: true}, ['new'], true
        test.done()
    'preserve nested old value': (test) ->
        result = nested: old: true, new: true
        initial = nested: old: true
        test.deepEqual result, deepSet initial, ['nested', 'new'], true
        test.done()
    'preserve deep nesting': (test) ->
        initial =
            nest:
                a: a: true
        result =
            nest:
                a: a: true
                b: b: true
        test.deepEqual result, deepSet initial, ['nest', 'b', 'b'], true
        test.done()
