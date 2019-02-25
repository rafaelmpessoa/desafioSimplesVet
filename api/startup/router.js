const bodyparser = require('body-parser')
const cors = require('cors')
const racas = require('../router/racas')
const animais = require('../router/animais')


module.exports = function(app){
    app.use(bodyparser.json())
    app.use(bodyparser.urlencoded({extended:true}))
    app.use(cors())
    app.use('/api/racas',racas)
    app.use('/api/animais',animais)
}