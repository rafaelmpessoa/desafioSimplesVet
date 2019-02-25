const mysql = require('mysql')

const connection = mysql.createConnection({
    host: 'aa1jfr6riutsdc7.cc7xhgf7bcgs.us-east-2.rds.amazonaws.com',
    user: 'selecaofullstack',
    password: 'barcelona',
    database: 'simplesvet'
});


connection.connect(err => {
    if (err) {
        console.error('error connecting: ', err.stack)
        return
    }
    console.log('connected!')
})


module.exports = connection
