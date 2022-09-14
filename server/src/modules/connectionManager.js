const sizeof = require('object-sizeof')
const { v4 } = require('uuid')
class ConnectionManager {

    // Called on init
    constructor(server){
        this.server = server
        this.heartBeatCount = 0
        this.responseRecord = {}
        setInterval(this.sendHeartBeat, 250, this.server)
    }
    
    sendHeartBeat(server){
        let connectionManager = server.connectionManager
        connectionManager.heartBeatCount += 1

        for (var key in server.clients){
            let ip = server.clients[key]["ip"]
            let port = server.clients[key]["port"]

            let data = {}
            data.type = 0
            data.count = connectionManager.heartBeatCount

            server.socket.send(data, port, ip)
        }

        setTimeout(connectionManager.onHeartBeatTimeout, 125, server)
    }

    addToResponseRecord(client, count){
        this.responseRecord[client] = count
    }

    // Called to detect disconnections
    onHeartBeatTimeout(server){
        let connectionManager = server.connectionManager
        // Loop through the record
        for (var key in connectionManager.responseRecord){
            if (connectionManager.responseRecord.hasOwnProperty(key)){

                // Give space for 5 beats 
                if (connectionManager.responseRecord[key] < connectionManager.heartBeatCount - 5){
                    connectionManager.onPlayerDisconnect(key)
                }
            }
        }
    }

    onPlayerConnect(id){
        let client = this.server.clients[id]
        console.log(`[${id}] New client from ${client["ip"]}:${client["port"]}`)

        let data = {}
        data.type = 1
        data.text = "hello"
        data.id = v4()
        this.server.socket.sendReliable(data, client["port"], client["ip"])
    }

    onPlayerDisconnect(id){
        // Remove from respons record
        delete this.responseRecord[id]
        delete this.server.clients[id]

        console.log(`[${id}] disconnected`)
    }
}

module.exports = ConnectionManager
