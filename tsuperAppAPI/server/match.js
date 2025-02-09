var commonlib = require("./common");
var connection = require('./db/dbconnection');
var mysqltrigger = require('./db/mysqlcontroller');
// source rating: https://calculator.academy/average-rating-calculator-star-rating/#:~:text=Average%20Rating%20Formula&text=Each%20value%20is%20worth%20a,results%20in%20the%20average%20rating

exports.rateDriver = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var clientName = body.clientName
	var rate = body.rate
	var comment = body.comment

    var totalService = 0;
    var newRating = 0;
	var resultdata = JSON.stringify({});
    function step(i){
        switch (i) {
        case 1:
            var strval = [driverName,driverID,clientName,rate,comment]
            var strsql = "INSERT INTO driver_rating "
                        +"(DateTimeIN,DriverName,DriverID,ClientName,Rate,Comment) "
                        +"VALUES(NOW(),?,?,?,?,?)";
            mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> rateDriver(1)]', function (result) {
                if (result == 'error') {
                    var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
                    res.json(resultObj);
                }else{
                    step(2);
                }
            });
            break;
        case 2:
            var rate1 = 0;
            var rate2 = 0;
            var rate3 = 0;
            var rate4 = 0;
            var rate5 = 0;
            getAllRatings(driverID, driverName, function(res) {
                totalService = res.result.length;
                const rateRes = res.result;
                for (let i = 0; i < totalService; i++) {
                    const rate = parseInt(rateRes[i].Rate);
                    switch (rate) {
                    case 1:
                        rate1 += 1;
                        break;
                    case 2:
                        rate2 += 1;
                        break;
                    case 3:
                        rate3 += 1;
                        break;
                    case 4: 
                        rate4 += 1;
                        break;
                    case 5:
                        rate5 += 1;
                        break;
                    default:
                        break;
                    }

                    if (i == (totalService-1)){
                        const totalRated = rate1 + rate2 + rate3 + rate4 + rate5
                        newRating = (1*rate1 + 2*rate2 + 3*rate3 + 4*rate4 + 5*rate5) / totalRated
                        newRating = Math.round(newRating)
                        step(3)
                    }
                }
            })
            break;
        case 3:
			var strval = [totalService,newRating,driverID]
			var strsql = "UPDATE users SET Extra1=?, Extra2=? "
						+"WHERE ID=? LIMIT 1"
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[match.js -> rateDriver(3)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
                    var resultObj = {
                        "data":  "[]",
                        "status": "000",
                        "message": "Success"
                    }
                    res.json(resultObj);
				}
			});
            break;
        default:
            break;
        }
    }
    step(1)
}

exports.fetchReviewRating = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName

    getAllRatings(driverID,driverName, function(result) {
        var resultObj = {
            "data": result.result.length > 0 ? result.result : null,
            "status": "000",
            "message": "Success"
        }
        res.json(resultObj);
    })
}

function getAllRatings(driverID, driverName, callback){
    var strval = [driverID,driverName]
    var strsql = "SELECT * FROM driver_rating "
                +"WHERE DriverID=? AND DriverName=?";
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[match.js -> getAllRatings()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            const json = {
                status: "000",
                result: result
            }
            callback(json)
        }
    });
}

exports.getMatchUser = function (req, res) {
	var body = req.body;
	var userID = body.userID
	var type = body.type

	var resultdata = JSON.stringify({});
    var strval = [userID]
    var strsql = "SELECT * FROM match_users "
                +"WHERE UserID=? AND (Status='PENDING' OR Status='SPECIAL') LIMIT 1";
    if (type == "Driver") {
        strsql = "SELECT * FROM match_users "
                +"WHERE DriverID=? AND (Status='PENDING' OR Status='ENDED' OR Status='SPECIAL') LIMIT 1";
    }
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[match.js -> getMatchUser()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
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

exports.startFindMatch = function (req, res) {
	var body = req.body;
	var userID = body.userID;
	var userName = body.userName;
	var carModel = body.carModel;
	var transmission = body.transmission;
	var currentLocation = body.currentLocation;

	var resultdata = JSON.stringify({});
    var strval = [userID,userName,carModel,transmission,currentLocation]
    var strsql = "INSERT INTO match_queue "
                +"(DateTimeIN, ClientID, ClientName, CarModel, Transmission, CurrentLocation, Status) "
                +"Value(NOW(),?,?,?,?,?,'PENDING')";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> startFindMatch()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}

exports.startDriverFindMatch = function (req, res) {
	var body = req.body;
	var carModel = body.carModel;
	var transmission = body.transmission;

	var resultdata = JSON.stringify({});
    var strval = [carModel,transmission]
    var strsql = "SELECT * FROM match_queue "
                +"WHERE CarModel=? AND Transmission=? ";
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[match.js -> startDriverFindMatch()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
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
exports.stopFindMatch = function (req, res) {
	var body = req.body;
	var userID = body.userID
	var carModel = body.carModel
	var transmission = body.transmission
	var currentLocation = body.currentLocation

	var resultdata = JSON.stringify({});
    var strval = [userID,carModel,transmission,currentLocation]
    var strsql = "DELETE FROM match_queue "
                +"WHERE ClientID=? AND CarModel=? AND Transmission=? AND CurrentLocation=? AND Status='PENDING'";
    mysqltrigger.deleteQuery(connection.tsuper_connect, strsql, strval, '[match.js -> startFindMatch()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}

exports.matchFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var userID = body.userID
	var userName = body.userName
	var carModel = body.carModel
	var transmission = body.transmission
	var currentLocation = body.currentLocation

	var resultdata = JSON.stringify({});
    var strval = [driverID,driverName,userID,userName]
    var strsql = "INSERT INTO match_users "
                +"(DriverID, DriverName, UserID, UserName, Status) "
                +"VALUES(?,?,?,?,'PENDING')";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var strval = [userID,carModel,transmission,currentLocation]
            var strsql = "DELETE FROM match_queue "
                        +"WHERE ClientID=? AND CarModel=? AND Transmission=? AND CurrentLocation=? AND Status='PENDING'";
            mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', 
            function (result) {
                if (result == 'error') {
                    var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
                    res.json(resultObj);
                }else{
                    var resultObj = {
                        "data": "[]",
                        "status": "000",
                        "message": "Success"
                    }
                    res.json(resultObj);
                }
            });
        }
    });
}

exports.deleteMatchFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var userID = body.userID
	var userName = body.userName

	var resultdata = JSON.stringify({});
    var strval = [driverID,driverName,userID,userName]
    var strsql = "UPDATE match_users "
                +"SET Status='ENDED' "
                +"WHERE DriverID=? AND DriverName=? AND UserID=? AND UserName=? AND (Status='PENDING' OR Status='SPECIAL')";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', 
    function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}

exports.reqBookingMatchFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID

	var resultdata = JSON.stringify({});
    var strval = [driverID]
    var strsql = "SELECT * FROM users "
                +"WHERE ID=? LIMIT 1";
    mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[match.js -> reqBookingMatchFound()]', 
    function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": result.length > 0 ? result : null,
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}

exports.deleteMatchDriverFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var userID = body.userID
	var userName = body.userName

	var resultdata = JSON.stringify({});
    var strval = [driverID,driverName,userID,userName]
    var strsql = "DELETE from match_users "
                +"WHERE DriverID=? AND DriverName=? AND UserID=? AND UserName=? AND Status='ENDED'";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', 
    function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}


exports.completeReqMatchFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var userID = body.userID
	var userName = body.userName

	var resultdata = JSON.stringify({});
    var strval = [driverID,driverName,userID,userName]
    var strsql = "UPDATE match_users "
                +"SET Status='SPECIAL' "
                +"WHERE DriverID=? AND DriverName=? AND UserID=? AND UserName=? AND (Status='PENDING' OR Status='SPECIAL')";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', 
    function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}

exports.completeEndReqMatchFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var userID = body.userID
	var userName = body.userName

	var resultdata = JSON.stringify({});
    var strval = [driverID,driverName,userID,userName]
    var strsql = "UPDATE match_users "
                +"SET Status='COMPLETE' "
                +"WHERE DriverID=? AND DriverName=? AND UserID=? AND UserName=? AND (Status='PENDING' OR Status='SPECIAL')";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', 
    function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}


exports.declineReqMatchFound = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var userID = body.userID
	var userName = body.userName

	var resultdata = JSON.stringify({});
    var strval = [driverID,driverName,userID,userName]
    var strsql = "UPDATE match_users "
                +"SET Status='PENDING' "
                +"WHERE DriverID=? AND DriverName=? AND UserID=? AND UserName=? AND (Status='PENDING' OR Status='SPECIAL')";
    mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[match.js -> matchFound()]', 
    function (result) {
        if (result == 'error') {
            var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
            res.json(resultObj);
        }else{
            var resultObj = {
                "data": "[]",
                "status": "000",
                "message": "Success"
            }
            res.json(resultObj);
        }
    });
}