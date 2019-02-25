const connection = require('../startup/db')


exports.getAllAnimais = (req,res) => {

    let query = "SELECT * FROM vw_animais ";
    connection.query(query,(error,results,fields) => {
        if (error) return res.status(404).send(error.message)
        const pets = results.map(e => {
            e.raca = {
                id: e.codRaca,
                raca: e.raca
            }
            e.isAlive = e.isAlive === 'true' ? false : true;
            e.kindOfPet = parseInt(e.kindOfPet);
            e.gender = e.gender.substring(0,1);
            return e
        })

        return res.status(200).send(pets)

    })

}


exports.updateAnimal = (req,res) => {
    const animalId = req.params.id
    if(!animalId) return res.status(404).send("Necessário passar um ID.")

    const pet = req.body
    pet.dtBorn = formatDate(pet.dtBorn)
    pet.dtDeath = pet.dtDeath ? "'" + formatDate(pet.dtDeath) + "'" : null
    const query = `call sp_animal_update(${animalId},'${pet.name}','${pet.gender}',${pet.kindOfPet},'${pet.chip}','${pet.dtBorn}',${pet.dtDeath},${pet.raca.id})`

    connection.query(query,(err,result) => {
        if(err) return res.status(404).send(err.message)
        return res.status(200).send(result)
    })

}


exports.postAnimal = (req,res) => {
    const pet = req.body
    pet.dtBorn = formatDate(pet.dtBorn)
    pet.dtDeath = pet.dtDeath ? "'" + formatDate(pet.dtDeath) + "'" : null
    const imgPath = Math.floor(Math.random() * 5) + 1  
    const query = `call sp_animal_insert('${pet.name}','${pet.gender}',${pet.kindOfPet},'${pet.chip}','${pet.dtBorn}',${pet.dtDeath},${pet.raca.id},${imgPath})`
    connection.query(query,(err,result) => {
        if(err) return res.status(404).send(err.message)
        return res.status(200).send(result)
    })
}




function formatDate(date) {
    let d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}