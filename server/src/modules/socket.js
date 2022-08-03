const dgram = require('dgram')
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
            if (!this.server.clients.hasOwnProperty(`${remote.address}-${remote.port}`)){
                // New Connection
                this.server.clients[`${remote.address}-${remote.port}`] = {uuid : v4()}
                client = this.server.clients[`${remote.address}-${remote.port}`]
                console.log(`[${client.uuid}] New client from ${remote.address}:${remote.port}`)
            }
            else{
                client = this.server.clients[`${remote.address}-${remote.port}`]
            }

            // Handle data
            data = JSON.parse(buf)
            console.log(`[${client.uuid}] : ${data}`)
       })
    }

    send(data, port, ip){
        this.socket.send(data, port, ip)
    }

}

module.exports = Socket
