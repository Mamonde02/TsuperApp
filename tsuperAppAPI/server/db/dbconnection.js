var mysql = require('mysql');
// host            : 'LAPTOP-9CIHOHMA',


var connection = {
    tsuper_connect  : mysql.createPool({
        connectionLimit :  100, //important
        host            : 'localhost',
        port            :  3306,
        user            : 'root',
        password        : 'valeroso',
        database        : 'tsuperdb',
        debug           :  true
    }),
    tsuper_chat  : mysql.createPool({
        connectionLimit :  100, //important
        host            : '127.0.0.1',
        port            :  3306,
        user            : 'root',
        password        : '',
        database        : 'tsuperchat',
        debug           :  false
    })
};
module.exports = connection;



// Connection Details 
// Name:  Local instance MySQL80 
// Host: localhost 
// Port: 3306 
// Login User: root 
// Current User: root@localhost 
// SSL cipher: TLS_AES_128_GCM_SHA256 
// Server 
// Product: MySQL Community Server - GPL 
// Version: 8.0.39 
// Connector 
// Version: C++ 9.0.0