class Server {
    constructor(){
        this.socket
        this.connectionManager
        this.ackManager
        this.worldState
        this.clients = {}
    }
}

module.exports = Server
