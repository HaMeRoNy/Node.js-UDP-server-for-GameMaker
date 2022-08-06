const env = 'dev'; // 'prod' or 'dev'

const common_config = {
    meta: {
        game_name: 'Node.js UDP server for GameMaker template',
        version: 'v0.1',
        server: 'unknown'
    },
    // some fundamental settings

};

const prod_config = {
    meta: {
        server: 'production'
    },
    env_name: 'prod',
    ip: '0.0.0.0',
    port: 8070,
    //db: 'mongodb://127.0.0.1:27017/online-game',
};

const dev_config = {
    meta: {
        server: 'development'
    },
    env_name: 'dev',
    ip: '127.0.0.1',
    port: 8070,
    //db: 'mongodb://127.0.0.1:27017/online-game',
};

const default_config = dev_config;

const config = {};
Object.assign(config, common_config);

if (env === 'production' || env === 'prod') {
    Object.assign(config, prod_config);
}
else if (env === 'development' || env === 'dev') {
    Object.assign(config, dev_config);
}
else {
    Object.assign(config, default_config);
}

console.log('Config loaded! environment: ' + config.env_name);

global.config = config;
export default config;
