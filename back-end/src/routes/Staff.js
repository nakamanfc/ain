const pool = require('../core/Pool')
const app = require('../core/Setting')

app.get('/staff', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ' + connection.threadId)
        connection.query('SELECT * from staff', (err, rows) => {
            connection.release() // return the connection to pool

            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
            // if(err) throw err
            console.log('The data from beer table are1: \n', rows)
        })
    })
})

// Get staff with StaffAddress
app.get('/staff/:address', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('SELECT * FROM staff WHERE address = ?', [req.params.address], (err, rows) => {
            connection.release() // return the connection to pool
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
            
            console.log('The data from beer table are: \n', rows)
        })
    })
});

// Delete a staff
// app.delete('/staff/:StaffID', (req, res) => {

//     pool.getConnection((err, connection) => {
//         if(err) throw err
//         connection.query('DELETE FROM staff WHERE staff.StaffID = ?', [req.params.StaffID], (err, rows) => {
//             connection.release() // return the connection to pool
//             if (!err) {
//                 res.send(`Beer with the record ID ${[req.params.StaffAddress]} has been removed.`)
//             } else {
//                 console.log(err)
//             }
            
//             console.log('The data from beer table are: \n', rows)
//         })
//     })
// });

// Add staff with data
app.post('/staff', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        
        const params = req.body
        connection.query('INSERT INTO staff SET ?', params, (err, rows) => {
        connection.release() // return the connection to pool
        if (!err) {
            res.send(`Beer with the record ID  has been added.`)
        } else {
            console.log(err)
        }
        
        console.log('The data from beer table aree: \n', rows)

        })
    })
});

app.post('/stafflogin', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        
        const { privatekey } = req.body
        connection.query('SELECT address FROM staff WHERE privatekey = ?', [privatekey], (err, rows) => {
        connection.release() // return the connection to pool
        if (!err) {
            res.send(rows)
        } else {
            console.log(err)
        }

        })
    })
});

app.get('/staffofcompany/:address', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('SELECT * FROM staff WHERE company = ?', [req.params.address], (err, rows) => {
            connection.release() // return the connection to pool
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
        })
    })
});

// Change avatar
app.put('/staffavatar', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const {avatar, address} = req.body

        connection.query('UPDATE staff SET avatar = ? WHERE address = ?', [avatar, address] , (err, rows) => {
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

app.put('/staff', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const {id, txhash, address} = req.body

        connection.query('UPDATE staff SET id = ?, txhash = ? WHERE address = ?', [id, txhash, address] , (err, rows) => {
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