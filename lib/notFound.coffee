module.exports = (msg = 'not found') -> (req, res, next) ->
    console.log msg
    res.writeHead 404
    res.end msg
