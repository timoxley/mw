{mergeObjects} = require '../lib/utility'

module.exports =
    simple: (test) ->
        test.deepEqual {simple: true}, mergeObjects {}, {simple: true}
        test.done()

    otherSimple: (test) ->
        test.deepEqual {simple: true}, mergeObjects {simple: true}, {}
        test.done()

    siblings: (test) ->
        expected =
            brother: true
            sister: true
        test.deepEqual expected, mergeObjects {brother: true}, {sister: true}
        test.done()

    nestedSiblings: (test) ->
        expected =
            sibling:
                brother: true
                sister: true
        test.deepEqual expected, mergeObjects {sibling: brother: true}, {sibling: {sister: true}}
        test.done()

    overwriteValues: (test) ->
        expected =
            value: true
        test.deepEqual expected, mergeObjects {value: false}, {value: true}
        test.done()

    mergeWithString: (test) ->
        test.deepEqual "foo", mergeObjects {}, "foo"
        test.done()
