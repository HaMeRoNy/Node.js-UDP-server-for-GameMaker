const { copyFileSync } = require("fs")

class AckManager{
    constructor(server){
        // Main interface
        this.server = server

        // Keep record of sent messages
        this.pendingMessages = []

        // Resends messages if lost
        setInterval(this.resendMessages, 100, this.server)
    }

    // Add message to pending messages
    addMessage(data, port, ip){
        this.pendingMessages.push({
            "ip" : ip,
            "port": port,
            "data" : data
        })
    }

    // Removes messages after being acknowledged
    removeMessage(data){
        var array = this.server.ackManager.pendingMessages
        var length = this.server.ackManager.pendingMessages.length
        for (var i = 0; i < length; i++){
            if (data == array[i]["data"]["id"]){
                array.splice(i, 1)
            }
        }
    }

    resendMessages(server){
        var array = server.ackManager.pendingMessages
        var length = array.length
        for (var i = 0; i < length; i++){
            server.socket.send(array[i]["data"], array[i]["port"], array[i]["ip"])
        }
    }

}

module.exports = AckManager