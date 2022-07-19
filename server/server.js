import './config.js';
import dgram from "dgram";

var server = dgram.createSocket("udp4");
var data; //data to send
var ServerPort = global.config.port;
var ServerIp = global.config.ip;

var uniqIdServer = 0;
function CreateGameServer(server_name,active){ // It is possible to create several servers. 
    this.server_id = uniqIdServer++;
    this.server_name = server_name;
    this.joined_players = []; // pull of players who joined to server
    this.active = active; //if player can join the server
}

function player(id,x,y,username,health,mana){ // In general data should come from moongodb but now it is absent.
    this.id = id;
    this.username = username;
    this.x = x;
    this.y = y;
    this.health = health;
    this.mana = mana;
}

var gameServers = [] 
gameServers.push(new CreateGameServer("first server",true))
gameServers.push(new CreateGameServer("second server",false)) 

const msgType = { //Enum for mesage type
    JOIN_HOST : 0,
    UPDATE_SERVER_LIST : 1,
    SET_PLAYER_STAT : 2
}

server.on('error', (err) => {
    console.log(`server error:\n${err.stack}`);
    server.close();
});

server.on("message", function(msg, rinfo){
    try {//Don't crash server
        //console.log("--> "+ String(msg));
        data = JSON.parse(msg);
        console.log(data)
        console.log(rinfo)

        switch (data.type){
            case msgType.JOIN_HOST: //button to join one of the servers
                join_game_host(data,rinfo);
            break
            case msgType.UPDATE_SERVER_LIST: // button to receive pull of serversw
                update_server_list(data,rinfo);
            break
        }
    }catch (Errr) {
        console.log(Errr)
    }
});

function update_server_list(data,rinfo){
    var serverList= [];
    for(let number in gameServers){
        serverList.push(gameServers[number].server_name); 
        data.serverList = serverList
    }
    server.send(JSON.stringify(data), rinfo.port , rinfo.address);
};
// Tryin to join one of the servers
function join_game_host(data,rinfo){
    let  serverId = data.joinedServer
    gameServers[serverId].joined_players.push([new player(0,0)]) // In general data should come from moongodb but now it is absent.
    data.resp = true;
    data.joinedServer = 1
    server.send(JSON.stringify(data), rinfo.port , rinfo.address);
    console.log(">>JOINED TO HOST<<")
};

server.bind(ServerPort,function(){
    console.log("Server started on " + ServerIp+":"+ServerPort)
});