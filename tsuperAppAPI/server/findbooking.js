var commonlib = require("./common");
var connection = require('./db/dbconnection');
var mysqltrigger = require('./db/mysqlcontroller');

exports.findBookingList = function (req, res) {
	var body = req.body;
	var bookingtype = body.bookingtype

	var resultdata = JSON.stringify({});
	var strval = [bookingtype]
	var strsql = "SELECT "
				+"TransactionNo,DateTimeIN,Locations,TotalAmount,"
				+"DateStart,DateEnd,Days,"
				+"Distance,PaymentMethod,BookerName,BookerID,"
				+"TypeOfService,Remarks,Status,Extra1 "
				+"FROM booking_queue "
				+"WHERE BookingType=? AND Status != 'CANCELLED'";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> findBookingList()]', function (result) {
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
exports.specialBookingList = function (req, res) {
	var body = req.body;
	var id = body.id

	var resultdata = JSON.stringify({});
	var strval = ['Driver Booking', id]
	var strsql = "SELECT "
				+"TransactionNo,DateTimeIN,Locations,TotalAmount,"
				+"DateStart,DateEnd,Days,"
				+"Distance,PaymentMethod,BookerName,BookerID,"
				+"TypeOfService,Remarks,Status,Extra1,Extra4 "
				+"FROM booking_queue "
				+"WHERE BookingType=? AND Status='SPECIAL' AND Extra2=? ";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> specialBookingList()]', function (result) {
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

exports.findDriverBookingQueue = function (req, res) {
	var body = req.body;
	var bookingID = body.bookingID

	var resultdata = JSON.stringify({});
	var strval = [bookingID]
	var strsql = "SELECT * FROM driver_queue "
				+"WHERE BookingID=? AND (Status !='COMPLETE' AND Status !='CANCELLED')";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> findDriverBookingQueue()]', function (result) {
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

exports.acceptBookingReqNow = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var profilePic = body.profilePic
	var serviceFee = body.serviceFee
	var bookingID = body.bookingID
	var bookerID = body.bookerID
	var bookerName = body.bookerName

    function step(i){
		switch (i) {
		case 1:
			var resultdata = JSON.stringify({});
			var strval = [driverID,driverName,profilePic,bookingID,bookerID,bookerName,serviceFee,"PENDING"]
			var strsql = "INSERT INTO driver_queue (DriverID, DriverName, ProfilePic, BookingID, BookerID, BookerName, ServiceFee, Status) "
						+"VALUES(?,?,?,?,?,?,?,?)";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> acceptBookingReqNow()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(2);
				}
			});
			break;
		case 2:
			const msg = "We found a driver to your booking. Please check your booking."
			var strval = [bookerID,msg,driverID]
			var strsql = "INSERT INTO notification "
						+"(DateTimeIN,UserID,Msg,Type,IsReceived,Status) "
						+"VALUES(Now(),?,?,'.',?,'ACTIVE')";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> insertBooking(4)]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
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
			break;
		default: 
			break;
		}
	}
	step(1)
}

exports.findPendingDriverBookingQueue = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName

	var resultdata = JSON.stringify({});
	var strval = [driverID,driverName]
	var strsql = "SELECT * FROM driver_queue "
				+"WHERE DriverID=? AND DriverName=? AND (Status !='COMPLETE' AND Status !='CANCELLED') LIMIT 1";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> findPendingDriverBookingQueue()]', function (result) {
		if (result == 'error') {
			var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
			res.json(resultObj);
		}else{
			var resultObj = {
				"data":  result.length > 0 ? result[0] : null,
				"status": "000",
				"message": "Success"
			}
			res.json(resultObj);
		}
	});
}

exports.checkDriverBookingQueueStatus = function (req, res) {
	var body = req.body;
	var trxnNO = body.trxnNO
	var driverID = body.driverID
	var driverName = body.driverName

	var resultdata = JSON.stringify({});
	var strval = [trxnNO,driverID,driverName]
	var strsql = "SELECT * FROM driver_queue "
				+"WHERE BookingID=? AND DriverID=? AND DriverName=? AND Status !='CANCELLED' LIMIT 1";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> checkDriverBookingQueueStatus()]', function (result) {
		if (result == 'error') {
			var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
			res.json(resultObj);
		}else{
			var resultObj = {
				"data":  result.length > 0 ? result[0] : null,
				"status": "000",
				"message": "Success"
			}
			res.json(resultObj);
		}
	});
}

exports.cancelWaitingBooking = function (req, res) {
	var body = req.body;
	var memberType = body.memberType
	var transactionNo = body.transactionNo
	var userName = body.userName
	var userID = body.userID

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [transactionNo,userName,userID]
			var strsql = "UPDATE booking_queue SET Status='CANCELLED' "
						+"WHERE TransactionNo=? AND BookerName=? AND BookerID=? LIMIT 1";
			if (memberType == "Driver"){
				strsql = "UPDATE driver_queue SET Status ='CANCELLED' "
						+"WHERE BookingID=? AND DriverName=? AND DriverID=? LIMIT 1";
			}
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> cancelWaitingBooking()]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				var strval = [transactionNo]
				var strsql = "DELETE FROM chat_customer "
							+"WHERE TransactionNo=?";
				mysqltrigger.deleteQuery(connection.tsuper_chat, strsql, strval, '[findbooking.js -> cancelWaitingBooking()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					if (memberType != "Driver"){
						step(3);
						return;
					}
					step(2);
				}
				});
			}
			});
			break;
		case 2:
			var strval = [".",".",".","PENDING",transactionNo]
			var strsql = "UPDATE booking_queue SET Extra2=?, Extra3=?, Extra4=?, Status=? "
						+"WHERE TransactionNo=? LIMIT 1"
			if (memberType == "Driver"){
				var strval = [`:${userID}`,".",".",".","PENDING",transactionNo]
				var strsql = "UPDATE booking_queue SET Remarks=?, Extra2=?, Extra3=?, Extra4=?, Status=? "
							+"WHERE TransactionNo=? LIMIT 1"
			}
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> cancelWaitingBooking(2)]', function (result) {
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
		case 3:
			var strval = [transactionNo]
			var strsql = "UPDATE driver_queue SET Status='CANCELLED' "
						+"WHERE BookingID=? LIMIT 1"
			mysqltrigger.deleteQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> cancelWaitingBooking(3)]', function (result) {
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
	step(1);
}

exports.selectDriverReq = function (req, res) {
	var body = req.body;
	var driverID = body.driverID
	var driverName = body.driverName
	var serviceFee = body.serviceFee
	var bookingID = body.bookingID
	var status = body.status

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [driverID,driverName,serviceFee,status,bookingID]
			var strsql = "UPDATE booking_queue SET Extra2=?, Extra3=?, Extra4=?, Status=? "
						+"WHERE TransactionNo=? LIMIT 1"
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> selectDriverReq()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					if (status != "BOOKED" && status != "COMPLETE") {
						var resultObj = {
							"data":  "[]",
							"status": "000",
							"message": "Success"
						}
						res.json(resultObj);
					}else{
						if (status == "COMPLETE"){
							step(4);
						}else{
							step(3);
						}
					}
				}
			});
			break;
		case 2:
			var strval = [bookingID]
			var strsql = "UPDATE driver_queue SET Status='BOOKED' "
						+"WHERE BookingID=? LIMIT 1"
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> selectDriverReq(2)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					const msg = "Your driver has arrived. Have a nice trip and enjoy!"
					var strval = [2,msg,driverID]
					var strsql = "INSERT INTO notification "
								+"(DateTimeIN,UserID,Msg,Type,IsReceived,Status) "
								+"VALUES(Now(),?,?,'.',?,'ACTIVE')";
					mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> insertBooking(4)]', 
					function (result) {
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
				}
			});
			break;
		case 3:
			var strval = [bookingID]
			var strsql = "UPDATE driver_queue SET Status='ARRIVING' "
						+"WHERE BookingID=? LIMIT 1"
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> selectDriverReq(2)]', function (result) {
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
		case 4:
			var strval = [bookingID]
			var strsql = "UPDATE driver_queue SET Status='COMPLETE' "
						+"WHERE BookingID=? LIMIT 1"
			mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> selectDriverReq(2)]', function (result) {
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
			break;x
		default:
			break;
		}
	}
	if (status == "BOOKED"){
		step(1);
	}else if (status == "COMPLETE"){
		step(1)
	}else{
		step(2);
	}
}

exports.cancelSpecialBooking = function (req, res) {
	var body = req.body;
	var transactionNo = body.transactionNo

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [transactionNo]
			var strsql = "UPDATE booking_queue SET Status ='CANCELLED' "
						+"WHERE TransactionNo=? LIMIT 1";
			mysqltrigger.deleteQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> cancelWaitingBooking(1)]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				var strval = [transactionNo]
				var strsql = "DELETE FROM chat_customer "
							+"WHERE TransactionNo=?";
				mysqltrigger.deleteQuery(connection.tsuper_chat, strsql, strval, '[findbooking.js -> cancelWaitingBooking(2)]', function (result) {
					if (result == 'error') {
						var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
						res.json(resultObj);
					}else{
						step(2);
					}
				});
			}
			});
			break;
		case 2:
			var strval = [transactionNo]
			var strsql = "UPDATE driver_queue SET Status='CANCELLED' "
						+"WHERE BookingID=? LIMIT 1"
			mysqltrigger.deleteQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> cancelWaitingBooking(3)]', function (result) {
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
			break
		}
	}
	step(1);
}

exports.acceptSpecialBooking = function (req, res) {
	var body = req.body;
	var transactionNo = body.transactionNo

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [transactionNo]
			var strsql = "UPDATE booking_queue SET Status ='BOOKED' "
						+"WHERE TransactionNo=? LIMIT 1";
			mysqltrigger.deleteQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> acceptSpecialBooking(1)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(2);
				}
			});
			break;
		case 2:
			var strval = [transactionNo]
			var strsql = "UPDATE driver_queue SET Status='BOOKED' "
						+"WHERE BookingID=? LIMIT 1"
			mysqltrigger.deleteQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> acceptSpecialBooking(2)]', function (result) {
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
			break
		}
	}
	step(1);
}

exports.countSpecialReqBooking = function (req, res) {
	var body = req.body;
	var id = body.id

	var resultdata = JSON.stringify({});
	var strval = [id]	
	var strsql = "SELECT "
				+"TransactionNo,DateTimeIN,Locations,TotalAmount,"
				+"DateStart,DateEnd,Days,"
				+"Distance,PaymentMethod,BookerName,BookerID,"
				+"TypeOfService,Remarks,Status,Extra1,Extra4 "
				+"FROM booking_queue "
				+"WHERE Status='SPECIAL' AND Extra2=? ";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> acceptSpecialBooking(2)]', function (result) {
		if (result == 'error') {
			var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
			res.json(resultObj);
		}else{
			var resultObj = {
				"data": result.length,
				"status": "000",
				"message": "Success"
			}
			res.json(resultObj);
		}
	});
}

function padValue(value) {
    return (value < 10) ? "0" + value : value;
}