const pool = require('../core/Pool')
const app = require('../core/Setting')

// Get all process
app.get('/process', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ' + connection.threadId)
        connection.query('SELECT * from process', (err, rows) => {
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

// search process with id
app.get('/process/:search', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('SELECT * FROM process WHERE id = ? OR name = ? OR staff = ? OR processcode = ? OR txhash = ?', [req.params.search, req.params.search, req.params.search, req.params.search, req.params.search], (err, rows) => {
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

// Delete a process
// app.delete('/process/:ID', (req, res) => {

//     pool.getConnection((err, connection) => {
//         if(err) throw err
//         connection.query('DELETE FROM process WHERE ID = ?', [req.params.ID], (err, rows) => {
//             connection.release() // return the connection to pool
//             if (!err) {
//                 res.send(`Beer with the record ID ${[req.params.ID ]} has been removed.`)
//             } else {
//                 console.log(err)
//             }
            
//             console.log('The data from beer table are: \n', rows)
//         })
//     })
// });

// Add process with data
app.post('/process', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        
        const params = req.body
        connection.query('INSERT INTO process SET ?', params, (err, rows) => {
        connection.release() // return the connection to pool
        if (!err) {
            res.send(`dao tao process.`)
        } else {
            console.log(err)
        }
        
        console.log('da tao thanh cong',rows)

        })
    })
});


// Change status process
app.put('/process', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const {id, txhash, staff, time} = req.body

        connection.query('UPDATE process SET id = ?, txhash = ? WHERE staff = ? and time = ?', [id, txhash , staff, time], (err, rows) => {
            connection.release() // return the connection to pool

            if(!err) {
                res.send(`Beer with the name: ${txhash} has been added.`)
            } else {
                console.log(err)
            }

        })

        console.log("da them thanh cong",req.body)
    })
})

module.exports = app;