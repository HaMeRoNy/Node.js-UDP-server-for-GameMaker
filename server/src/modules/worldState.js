const msgType = require("./msgType")

class WorldState{
    constructor(server){
        this.server = server
        this.playerStateCollection = {}
        setInterval(this.sendWorldState, 20, this.server)
    }

    sendWorldState(server){
        if (JSON.stringify(server.worldState.playerStateCollection) !== '{}'){
            let worldState = structuredClone(server.worldState.playerStateCollection)
            worldState.time = Date.now()
            for(var player in worldState){
                delete worldState[player]["T"]
            }
            worldState.type = msgType.WORLDSTATE
            server.socket.sendAll(worldState)
        }
    }
}

module.exports = WorldState
