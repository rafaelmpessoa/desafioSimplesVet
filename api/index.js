const express = require('express')
const app = express()


require('./startup/db')
require('./startup/router')(app)

const port = process.env.PORT || 3000
app.listen(port,() => console.log(`Server listening on port ${port}...`))