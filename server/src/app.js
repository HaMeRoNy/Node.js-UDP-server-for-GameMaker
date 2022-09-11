const Server = require('./modules/server')
const Socket = require("./modules/socket")
const ConnectionManager = require("./modules/connectionManager.js")
const AckManager = require("./modules/ackManager.js")

const server = new Server()
server.socket = new Socket(server)
server.connectionManager = new ConnectionManager(server)
server.ackManager = new AckManager(server)