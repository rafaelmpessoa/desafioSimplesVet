const express = require('express')
const router = express.Router()
const racas_controller = require('../controllers/racas')

//Obter todas as raças
router.get('/',racas_controller.getAllRacas)


module.exports = router