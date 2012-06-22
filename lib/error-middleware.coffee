module.exports = (req, res, err, name = '') ->
    console.error 'error while binding', name, err
    res.writeHead 500
    res.end 'Internal Server Error'
