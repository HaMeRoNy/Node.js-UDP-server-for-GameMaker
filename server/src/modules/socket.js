const dgram = require('dgram')
const { stringify } = require('querystring')
const { v4 } = require('uuid')
const msgType = require("./msgType")

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

            switch(data.type) {

                case msgType.HEARTBEAT:
                    let count = data.count
                    this.server.connectionManager.addToResponseRecord(client, count)
                break;

                case msgType.ACK:
                    this.server.ackManager.removeMessage(data.id)
                break;

                case msgType.RELIABLE:
                    this.server.ackManager.sendAck(remote.address, remote.port, data)
                    switch(data.method){
                        case "FetchServerTime":
                            data.serverTime = Date.now()
                            this.sendReliable(data, remote.port, remote.address)
                        break;

                        case "DetermineLatency":
                            this.sendReliable(data, remote.port, remote.address)
                        break;

                    }
                    
                break;

                case msgType.PLAYERSTATE:
                    let playerStateCollection = this.server.worldState.playerStateCollection
                    if (playerStateCollection.hasOwnProperty(client)){
                        if (playerStateCollection[client]["time"] < data.time){
                            this.server.worldState.playerStateCollection[client] = {time : data.time, x : data.x, y : data.y}
                        }
                    }
                    else{
                        this.server.worldState.playerStateCollection[client] = {time : data.time, x : data.x, y : data.y}
                    }
                break;
              }


       })
    }

    send(data, port, ip){
        this.socket.send(JSON.stringify(data), port, ip)
    }

    sendReliable(data, port, ip){
        data.type = msgType.RELIABLE
        data.id = v4()
        
        this.socket.send(JSON.stringify(data), port, ip)
        this.server.ackManager.addMessage(data, port, ip)
    }

    sendAllReliable(data){
        let clients = this.server.clients
        for (var key in clients){
            let msg = {} 
            Object.assign(msg, data)

            msg.type = msgType.RELIABLE
            msg.id = v4()

            this.socket.send(JSON.stringify(msg), clients[key]["port"], clients[key]["ip"])
            this.server.ackManager.addMessage(msg, clients[key]["port"], clients[key]["ip"])

        }
    }

    sendAll(data){
        let clients = this.server.clients
        for (var key in clients){
            this.socket.send(JSON.stringify(data), clients[key]["port"], clients[key]["ip"])
        }
    }
}

module.exports = Socket
