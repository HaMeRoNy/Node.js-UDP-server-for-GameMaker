const { v4 } = require('uuid')

class AckManager{
    constructor(server){
        // Main interface
        this.server = server
        this.pendingMessages = []
        setInterval(this.resendMessages, 1000, this.server)
    }


    addMessage(data, port, ip){
        this.pendingMessages.push({
            "ip" : ip,
            "port": port,
            "data" : data
        })
    }

    removeMessage(data){
        var array = server.ackManager.pendingMessages
        var length = server.ackManager.pendingMessages.length
        for (var i = 0; i < length; i++){
            if (data == array[i]){
                array.splice(i, 1)
            }
        }
    }

    resendMessages(server){
        var array = server.ackManager.pendingMessages
        var length = server.ackManager.pendingMessages.length
        for (var i = 0; i < length; i++){
            server.socket.send(array[i]["data"], array[i]["port"], array[i]["ip"])
        }
    }

}

module.exports = AckManager