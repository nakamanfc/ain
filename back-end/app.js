const app = require('./src/core/Setting')
const port = process.env.PORT || 5000;


const Company = require('./src/routes/Company')
const Process = require('./src/routes/Process')
const Staff = require('./src/routes/Staff')

// Listen on enviroment port or 5000
app.listen(port, () => console.log(`Listening on port ${port}`))