const sizeof = require('object-sizeof')

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

        let data = 0

        connectionManager.heartBeatCount += 1

        for (var key in server.clients){
            if (server.clients.hasOwnProperty(key)) {

                // Split key into ip and port
                let index = key.indexOf("-")
                let ip = key.substring(0, index)
                let port = key.substring(index + 1)

                server.sockey.send(data, port, ip)
            }
        }

        setTimeout(connectionManager.onHeartBeatTimeout, 125, server)

    }

    addToResponseRecord(client, count){
        this.responseRecord[client] = count
    }

    // Called to detect disconnections
    onHeartBeatTimeout(server){
        
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

    onPlayerConnec(player){

    }

    onPlayerDisconnect(player){

        // Remove from respons record
        delete this.responseRecord[player]

        // Remove from client list
        for (var key in this.server.clients){
            if (this.server.clients.hasOwnProperty(key)){

                if (this.server.clients[key].uuid = player){
                    delete this.server.clients[key]
                }
            }
        }
    }
}

module.exports = ConnectionManager