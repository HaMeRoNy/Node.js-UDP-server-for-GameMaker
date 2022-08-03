const Server = require('./modules/server')
const Socket = require("./modules/socket")

const server = new Server()
server.socket = new Socket(server)
