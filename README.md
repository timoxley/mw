This is a collection of useful middlewares.

# redirect

node middleware that handles redirection.

## Usage

```coffeescript
{redirect} = require 'middleware'

# redirects `/foo` to `/bar`
router.get '/foo',
    redirect '/bar'

# redirects `/foo/$var` to `/bar/$var`
router.get '/foo/:id',
    redirect (req) -> "/bar/#{req.params.id}"
```


# render

middleware to render arbitrary views.
This middleware can be used with all existing template engines.

## Usage

Middleware called before `render` should populate the `req.loaded` object
with data that the view should present to the client
`render` will send the output of `view req.loaded` to the client

## Example

```coffeescript
jsonView = (params) -> JSON.stringify params

router.get '/resource',
    (req, res, next) ->
        req.loaded =
            foo: 'bar'
            fitz: [1..10]
        next()
    render jsonView

# will render `'{"foo":"bar","fitz":[1,2,3,4,5,6,7,8,9,10]}'` to the
# client
```

# bind

Transforms an asynchronous function into a middleware.
The result of the function will be bound to `request.loaded`.

Use this library if you want to load async data in a clean
way.

## Short Description

Transforms an asynchronous function `f` into a middleware.
The middleware will call `f` with `(req, callback)`.
`f` has to call `callback` with `err, value`
which will cause `value` to be bound to `req.loaded[name]`.

## Usage

```coffeescript
bind name, (req, next) ->
    # do async stuff and call `next` when you are finished
    error = null
    result = 'result'
    next error, result
```

`name` is the directive where to save the results from `function`.

```coffeescript
# will bind the result of asnycMethod to `req.loaded.foo`
bind 'foo', (req, next) -> asyncMethod next
```

`name` can be nested.

```coffeescript
# will bind the result of asyncMethod to `req.loaded.foo.bar`
bind 'foo.bar', (req, next) -> asyncMethod next
```

If the asynchronous method returns an error the process is aborted
and a Status Code of 500 is returned to the user.

## Example

```coffeescript
router.get '/user',
    bind 'users.all', (req, next) -> dao.user.all next
    (req, res, next) -> next console.log 'loaded users', req.loaded.users.all
    # will output the result of `dao.user.all`
    render view.user.all

router.get '/user/:id',
    bind 'user.object', (req, next) -> dao.user.byId req.params.id, next
    render view.user.show
```


# exec

Simple way to create middleware that should not modify the `response`.
Takes care of errors.
Useful for tasks like updating the database.

## Example

```coffeescript
router.post '/user/:id',
    exec (req, next) -> dao.user.update req.params.id, req.body, next
```

## Without `exec`

```coffeescript
router.post '/user/:id',
    dao.user.update req.params.id, req.body, (err) ->
        if err?
            res.writeHead 500
            res.end 'Internal Server Error'
        else
            next()
```


# flash

used for setting, loading flash messages.

```coffeescript

{loadFlash, flash, redirect, render} = require 'mw'

router.post '/foo',
    flash 'hello flash'
    redirect 'back'

router.get '/foo'
    loadFlash
    (req, res, next) -> next console.log req.loaded.flash
    # prints {message: 'hello flash', type: 'info'
    # view.foo will receive `req.loaded` and can print them to the dom
    render view.foo

```

A view helper for displaying alerts can be found in
[dombox](https://github.com/mren/dombox).

# condition

`if-else` statement as a middleware

```coffeescript

{condition} = require 'mw'

# the condition is dependant on the state
# in this example we use this simplified conditions
alwaysTrue = (req) -> true
alwaysFalse = (req) -> false

# this would be a useful condition
isLoggedIn = (req) -> req.session?.user?

log = (msg) -> (req, res, next) -> next console.log msg


# for details about sequenz see https://github.com/snd/sequenz
http.createServer sequenz [
    condition alwaysTrue log('this middleware is executed'), log('this middleware is ignored')
    condition alwaysFalse log('this middleware is ignored'), log('this middleware is executed')
    condition alwaysFalse log('nothing is shown and the next middleware is executed')
    (req, res, next) -> req.end()
]
```
