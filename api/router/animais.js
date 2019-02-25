const express = require('express')
const router = express.Router()
const animais_controller = require('../controllers/animais')

//Obter todas os Animais
router.get('/',animais_controller.getAllAnimais)

router.put('/',animais_controller.updateAnimal)

router.post('/',animais_controller.postAnimal)



module.exports = router