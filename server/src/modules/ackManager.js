const { copyFileSync } = require("fs")
const msgType = require("./msgType")

class AckManager{
    constructor(server){
        // Main interface
        this.server = server

        // Keep record of sent messages
        this.pendingMessages = []

        // Keep record of recevied messages
        this.received_messages = []

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

    sendAck(ip, port, data){
        // Extract data
		var msgId = data.id
				
		// Makes sure we dont accept a message twice
		for (var i = 0; i < this.received_messages.length; i++) {
			if (this.received_messages[i] == msgId){
                var data = {}
                data.id = msgId
                data.type = msgType.ACK
                this.server.socket.send(data, port, ip)
				
				return
			}
		}
				
		// Make sure the array does not get too big
		if (this.received_messages.length > 50){
			this.received_messages.pop()
		}
				
		// Remembers recent messages
        this.received_messages.push(msgId)
		
		// Resend id
        var data = {};
        data.id = msgId
        data.type = msgType.ACK
        this.server.socket.send(data, port, ip)
        
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