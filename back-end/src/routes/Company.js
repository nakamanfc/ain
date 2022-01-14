const pool = require('../core/Pool')
const app = require('../core/Setting')

// Get all company
app.get('/company', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ' + connection.threadId)
        connection.query('SELECT * from company', (err, rows) => {
            connection.release() // return the connection to pool
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }

            // if(err) throw err
            console.log('The data from beer table are: \n', rows)
        })
    })
})

// Get company with id
app.get('/company/:address', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('SELECT * FROM company WHERE address = ?', [req.params.address], (err, rows) => {
            connection.release() // return the connection to pool
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
            
            console.log('The data from company table are: \n', rows)
        })
    })
});

app.post('/companylogin', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        
        const { privatekey } = req.body
        connection.query('SELECT address FROM company WHERE privatekey = ?', [privatekey], (err, rows) => {
        connection.release() // return the connection to pool
        if (!err) {
            res.send(rows)
        } else {
            console.log(err)
        }

        })
    })
});

// Delete a company
// app.delete('/company/:CompanyID', (req, res) => {

//     pool.getConnection((err, connection) => {
//         if(err) throw err
//         connection.query('DELETE FROM company WHERE CompanyID = ?', [req.params.CompanyID], (err, rows) => {
//             connection.release() // return the connection to pool
//             if (!err) {
//                 res.send(`Beer with the record ID ${[req.params.CompanyID]} has been removed.`)
//             } else {
//                 console.log(err)
//             }
            
//             console.log('The data from beer table are: \n', rows)
//         })
//     })
// });

// Add company with data
app.post('/company', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        
        const params = req.body
        connection.query('INSERT INTO company SET ?', params, (err, rows) => {
        connection.release() // return the connection to pool
        if (!err) {
            res.send(`done`)
        } else {
            console.log(err)
        }

        })
    })
});


// Change company data
app.put('/company', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const { id, txhash, address } = req.body

        connection.query('UPDATE company SET id = ?, txhash = ? WHERE address = ?', [id, txhash, address] , (err, rows) => {
            connection.release() // return the connection to pool

            if(!err) {
                res.send(`done`)
            } else {
                console.log(err)
            }

        })

        console.log(req.body)
    })
})

//change avatar
app.put('/companyavatar', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const { avatar, address } = req.body

        connection.query('UPDATE company SET avatar = ? WHERE address = ?', [avatar, address] , (err, rows) => {
            connection.release() // return the connection to pool

            if(!err) {
                res.send(`Beer with the name: ${address} has been added.`)
            } else {
                console.log(err)
            }

        })

        console.log(req.body)
    })
})

module.exports = app;