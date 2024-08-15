var express = require("express");
var commonlib = require("./common");
var connection = require('./db/dbconnection');
var mysqltrigger = require('./db/mysqlcontroller');

exports.insertBooking = function (req, res) {
	var body = req.body;
	var bookername = body.bookername
	var bookerid = body.bookerid
	var locations = body.locations
	var datestart = body.datestart
	var dateend = body.dateend
	var days = body.days
	var typeservice = body.typeservice
	var bookingtype = body.bookingtype
	var totalamount = body.totalamount
	var distance = body.distance
	var carinfo = body.carinfo
	var paymentmethod = body.paymentmethod
	
	var count;
	var trxnNo;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strsql = "SELECT Count FROM trxnrecord WHERE Name='booking'";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, [], '[booking.js -> insertBooking()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					var newDate = new Date();

					var random = commonlib.randomNumber(10)
					var currentCount = result.length <= 0 ? 0 : result[0].Count
					count = parseInt(currentCount) + 1;
					trxnNo = (padValue(newDate.getMonth() + 1).toString() + (newDate.getFullYear()).toString() + random + count).toString();
					step(2);
				}
			});
			break;
		case 2:
			var strsql = "UPDATE trxnrecord SET Count=? WHERE Name='booking'";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, [count], '[booking.js -> insertBooking()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(3)
				}
			});
			break;
		case 3:
			var strval = [trxnNo,locations,datestart,dateend,days,typeservice,bookingtype,totalamount,distance,paymentmethod,bookername,bookerid,"PENDING",carinfo]
			var strsql = "INSERT INTO booking_queue "
						+"(DateTimeIN,TransactionNo,Locations,DateStart,"
						+"DateEnd,Days,TypeOfService,BookingType,"
						+"TotalAmount,Distance,PaymentMethod,"
						+"BookerName,BookerID,Status,Remarks,Extra1,Extra2,Extra3,Extra4) "
						+"VALUES(Now(),?,?,?,?,?,?,?,?,?,?,?,?,?,'.',?,'.','.','.')";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> insertBooking(3)]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				step(4);
			}
			});
			break;
		case 4:
			const msg = "You successfully choose the "+typeservice+". Click here for more info.##Someone booked "+typeservice+" and currently looking for driver. Click for more info."
			var strval = [bookerid,msg,bookerid]
			var strsql = "INSERT INTO notification "
						+"(DateTimeIN,UserID,Msg,Type,IsReceived,Status) "
						+"VALUES(Now(),?,?,'Driver',?,'ACTIVE')";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> insertBooking(4)]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				var resultObj = {
					"data": trxnNo,
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

exports.viewHistory = function (req, res) {
	var body = req.body;
	var isdriver = body.isdriver
	var bookername = body.bookername
	var bookerid = body.bookerid
	var bookingtype = body.bookingtype

	var resultdata = JSON.stringify({});
	var strval = [bookername,bookerid,bookingtype]
	var strsql = "SELECT TransactionNo,DateTimeIN,Locations,TotalAmount,"
				+"Distance,BookerName,BookerID,TypeOfService,"
				+"Status,Extra1,Extra4 "
				+"FROM booking_queue "
				+"WHERE BookerName=? AND BookerID=? AND BookingType=?";
	if (isdriver == 1) {
		strval = [bookerid,bookername]
		strsql = "SELECT TransactionNo,DateTimeIN,Locations,TotalAmount,"
				+"Distance,BookerName,BookerID,TypeOfService,"
				+"Status,Extra1,Extra4 "
				+"FROM booking_queue "
				+"WHERE Extra2=? AND Extra3=?";
	}
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> viewHistory()]', function (result) {
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

exports.fetchAllBooking = function (req, res) {
	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = []
			var strsql = "SELECT ID,TransactionNo,DateTimeIN,Locations,TotalAmount,Distance,BookerName,BookerID,TypeOfService,Extra2,Extra3,Status "
						+"FROM booking_queue";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> fetchAllBooking()]', function (result) {
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
			break;
		default:
			break;
		}
	}
	step(1);
}

exports.findPendingBooking = function (req, res) {
	var body = req.body;
	var bookername = body.bookername
	var bookerid = body.bookerid

	var resultdata = JSON.stringify({});
	var strval = [bookername,bookerid]
	var strsql = "SELECT ID,TransactionNo,DateTimeIN,Locations,"
				+"TotalAmount,DateStart,DateEnd,Days,"
				+"Distance,PaymentMethod,BookerName,"
				+"BookerID,TypeOfService,Remarks,Extra1,Extra2,Extra3,Status "
				+"FROM booking_queue "
				+"WHERE BookerName=? AND BookerID=? AND (Status !='COMPLETE' AND Status != 'CANCELLED') LIMIT 1"
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> findPendingBooking()]', function (result) {
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

exports.specialBooking = function (req, res) {
	var body = req.body;
	var bookername = body.bookername
	var bookerid = body.bookerid
	var locations = body.locations
	var datestart = body.datestart
	var dateend = body.dateend
	var days = body.days
	var typeservice = body.typeservice
	var bookingtype = body.bookingtype
	var totalamount = body.totalamount
	var distance = body.distance
	var carinfo = body.carinfo
	var paymentmethod = body.paymentmethod
	
	var profilePic = body.profilePic
	var serviceFee = body.serviceFee
	var driverID = body.driverID
	var driverName = body.driverName
	
	var count;
	var trxnNo;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strsql = "SELECT Count FROM trxnrecord WHERE Name='booking'";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, [], '[booking.js -> insertBooking()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					var newDate = new Date();

					var random = commonlib.randomNumber(10)
					var currentCount = result.length <= 0 ? 0 : result[0].Count
					count = parseInt(currentCount) + 1;
					trxnNo = (padValue(newDate.getMonth() + 1).toString() + (newDate.getFullYear()).toString() + random + count).toString();
					step(2);
				}
			});
			break;
		case 2:
			var strsql = "UPDATE trxnrecord SET Count=? WHERE Name='booking'";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, [count], '[booking.js -> insertBooking()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(3)
				}
			});
			break;
		case 3:
			var strval = [trxnNo,locations,datestart,dateend,
				days,typeservice,bookingtype,totalamount,
				distance,paymentmethod,bookername,bookerid,
				"SPECIAL",carinfo,driverID,driverName,serviceFee]
			var strsql = "INSERT INTO booking_queue "
						+"(DateTimeIN,TransactionNo,Locations,DateStart,"
						+"DateEnd,Days,TypeOfService,BookingType,"
						+"TotalAmount,Distance,PaymentMethod,"
						+"BookerName,BookerID,Status,Remarks,Extra1,Extra2,Extra3,Extra4) "
						+"VALUES(Now(),?,?,?,?,?,?,?,?,?,?,?,?,?,'.',?,?,?,?)";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> insertBooking(3)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(4);
				}
			});
			break;
		case 4:
			var strval = [driverID,driverName,profilePic,trxnNo,bookerid,bookername,serviceFee,"SPECIAL"]
			var strsql = "INSERT INTO driver_queue (DriverID, DriverName, ProfilePic, BookingID, BookerID, BookerName, ServiceFee, Status) "
						+"VALUES(?,?,?,?,?,?,?,?)";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[findbooking.js -> acceptBookingReqNow()]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(5);
				}
			});
			break;
		case 5:
			const msg = "Someone requested booked "+typeservice+" and currently looking for you. Click for more info."
			var strval = [driverID,msg,driverID]
			var strsql = "INSERT INTO notification "
						+"(DateTimeIN,UserID,Msg,Type,IsReceived,Status) "
						+"VALUES(Now(),?,?,'.',?,'ACTIVE')";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[booking.js -> insertBooking(4)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					var resultObj = {
						"data": trxnNo,
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

function padValue(value) {
    return (value < 10) ? "0" + value : value;
}