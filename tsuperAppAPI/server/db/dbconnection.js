var mysql = require('mysql');
require('dotenv').config();

var connection = {
    tsuper_connect  : mysql.createPool({
        connectionLimit :  100, //important
        host            : '127.0.0.1',
        port            :  3306,
        user            : 'root',
        password        :  process.env.DB_PASSWORD,
        database        : 'tsuperdb',
        debug           :  false
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