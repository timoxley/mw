bind = require '../lib/bind'

module.exports =
    'simple': (test) ->
        middleware = bind 'foo', (req, next) -> next null, true
        req = {}
        middleware req, null, ->
            test.equal req.loaded.foo, true
            test.done()
    'error': (test) ->
        middleware = bind 'xxx', (req, next) -> next 'ERROR'
        req = {}
        res =
            writeHead: (status) -> test.equal 500, status
            end: -> test.done()
        middleware req, res
    'does not overwrite siblings': (test) ->
        req = loaded: existing: true
        middleware = bind 'new', (req, next) -> next null, true
        middleware req, null, ->
            test.ok req.loaded.existing
            test.done()

    'can overwrite same element': (test) ->
        req = loaded: existing: false
        middleware = bind 'existing', (req, next) -> next null, true
        middleware req, null, ->
            test.ok req.loaded.existing
            test.done()

    'wont overwrite nested element': (test) ->
        req = loaded: existing: foo: bar: fitz: true
        middleware = bind 'existing.new', (req, next) -> next null, true

        expected =
            loaded: existing:
                foo: bar: fitz: true
                new: true
        middleware req, null, ->
            test.deepEqual req, expected
            test.done()

    'can overwrite deep nested same element': (test) ->
        req = loaded: namespace: element: false
        middleware = bind 'namespace.element', (req, next) -> next null, true
        middleware req, null, ->
            test.ok req.loaded.namespace.element
            test.done()
