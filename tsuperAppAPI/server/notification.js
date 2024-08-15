var commonlib = require("./common");
var connection = require('./db/dbconnection');
var mysqltrigger = require('./db/mysqlcontroller');

exports.fetchNotif = function (req, res) {
    var body = req.body;
    var userID = body.userID
    var membertype = body.membertype
    
    var strval = [userID,membertype]
    var strsql = "SELECT * FROM notification "
                +"WHERE UserID=? OR Type=?";
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[notification.js -> fetchNotif()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': [], 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": result,
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}

exports.updateIsReceivedNotif = function (req, res) {
    var body = req.body;
    var userID = body.userID;
    var ID = body.ID
    
    var strval = [ID]
    var strsql = "SELECT IsReceived FROM notification "
                +"WHERE ID=?";
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[updateNotif.js -> updateIsReceivedNotif(1)]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': [], 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            const viewer = result[0].IsReceived == "" ? userID : result[0].IsReceived +","+ userID
            var strval1 = [viewer,ID]
            var strsql1 = "UPDATE notification "
                        +"SET IsReceived=? WHERE ID=?";
            mysqltrigger.updateQuery(connection.tsuper_connect, strsql1, strval1, '[updateNotif.js -> updateIsReceivedNotif(2)]', function (result) {
                if (result == 'error') {
                    var resultObj = {'data': [], 'status': 'error', 'message': 'Server Error'};
                    res.json(resultObj);
                }else{
                    var resultObj = {
                        "data": [],
                        "status": "000",
                        "message": "Success"
                    }
                    res.json(resultObj);
                }
            });
        }
    });
}

exports.updateNotif = function (req, res) {
    var body = req.body;
    var userID = body.userID;
    var ID = body.ID
    
    var strval = [ID]
    var strsql = "SELECT Viewer FROM notification "
                +"WHERE ID=?";
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[updateNotif.js -> updateNotif(1)]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': [], 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            const viewer = result[0].Viewer == "" ? userID : result[0].Viewer +","+ userID
            var strval1 = [viewer,ID]
            var strsql1 = "UPDATE notification "
                        +"SET Viewer=? WHERE ID=?";
            mysqltrigger.updateQuery(connection.tsuper_connect, strsql1, strval1, '[updateNotif.js -> updateNotif(2)]', function (result) {
                if (result == 'error') {
                    var resultObj = {'data': [], 'status': 'error', 'message': 'Server Error'};
                    res.json(resultObj);
                }else{
                    var resultObj = {
                        "data": [],
                        "status": "000",
                        "message": "Success"
                    }
                    res.json(resultObj);
                }
            });
        }
    });
}