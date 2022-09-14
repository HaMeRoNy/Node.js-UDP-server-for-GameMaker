const dgram = require('dgram')
const { stringify } = require('querystring')
const { v4 } = require('uuid')


class Socket{

    // Called on init
    constructor(server){

        // Main interface
        this.server = server

        //Create socket
        this.socket = dgram.createSocket("udp4")
        this.socket.bind(9091, '127.0.0.1')

        // Register on startup listener
        this.socket.on('listening', () => {
            let address = this.socket.address()
            console.log(`UDP server listening on ${address.address}:${address.port}`)
        })

        // Register on message listener
        this.socket.on('message', (buf, remote) => {
            // Check if there is a connection or not
            let client = null
            let clients = this.server.clients
            
            // Loop through all clients and check if the ip and port already exist
            let if_connection = true
            for (var key in clients){
                if (clients[key]["ip"] == remote.address && clients[key]["port"] == remote.port){
                    // If already connected
                    if_connection = false
                    client = key
                }
            }
            
            // If a new connection
            if (if_connection == true){
                let id = v4()
                this.server.clients[id] = {"ip" : remote.address, "port" : remote.port}
                client = id

                this.server.connectionManager.onPlayerConnect(client)
            }

            // Handle data
            var data
            data = JSON.parse(buf)

            if (data.type == 0){
                let count = data.count
                this.server.connectionManager.addToResponseRecord(client, count)
            }else if (data.type ==1){
                this.server.ackManager.removeMessage(data.data)
            }
       })
    }

    send(data, port, ip){
        this.socket.send(JSON.stringify(data), port, ip)
    }

    sendReliable(data, port, ip){
        this.socket.send(JSON.stringify(data), port, ip)
        this.server.ackManager.addMessage(data, port, ip)
    }
}

module.exports = Socket
