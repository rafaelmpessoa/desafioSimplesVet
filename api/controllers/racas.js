const connection = require('../startup/db')


exports.getAllRacas = (req,res) => {
    const situacao = req.query.situacao
    const especie_cod = req.query.especie_cod
    let query = "SELECT * FROM vw_racas ";
    //FORMATAR QUERY COM OS PARAMETROS.
    if(situacao || especie_cod) {
        query = query + "WHERE ";
        if(situacao) {
            query = query + "situacao = '" + situacao + "'";
            if(especie_cod) {
                query = query + " and especie_cod = " + especie_cod;
            }
        }else {
            if(especie_cod) {
                query = query + "especie_cod = " + especie_cod;
            }
        }
    } 

    connection.query(query,(error,results,fields) => {
        if (error) return res.status(404).send(error.message)
        return res.status(200).send(results)

    })

}