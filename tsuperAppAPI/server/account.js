var express = require("express");
var commonlib = require("./common");
var connection = require('./db/dbconnection');
var mysqltrigger = require('./db/mysqlcontroller');


exports.loginTsuper = function (req, res) {
	var body = req.body;
	var email = body.email
	var pwd = body.pwd
	var membertype = body.membertype

	var resultdata = JSON.stringify({});
	var strval = [email,pwd,membertype]
	var strsql = "SELECT * FROM users WHERE Email=? AND Password=?";
	mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> loginTsuper()]', function (result) {
		if (result == 'error') {
			var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
			res.json(resultObj);
		}else{
			if (result.length <= 0){
				var resultObj = {
					"data": resultdata,
					"status": "001",
					"message": "Account does not exist."
				}
				res.json(resultObj);
			}else{
				var resultObj = {
					"data": result[0],
					"status": "000",
					"message": "Success"
				}
				res.json(resultObj);
			}
		}
	});
}

exports.validateIfUserExist = function (req, res) {
	var body = req.body;
	var phone = body.phone
	var email = body.email
	var membertype = body.membertype

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [email,phone,membertype]
			var strsql = "SELECT Email, PhoneNumber FROM users WHERE Email=? AND PhoneNumber=? AND MemberType=?";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> validateIfUserExist()]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				if (result.length > 0){
					var resultObj = {
						"data": resultdata,
						"status": "001",
						"message": "This account is already registered."
					}
					res.json(resultObj);
				}else{
					var resultObj = {
						"data": resultdata,
						"status": "000",
						"message": "Success"
					}
					res.json(resultObj);
				}
			}
			});
			break;
		default:
			break;
		}
	}
	step(1);
}

exports.registerTsuper = function (req, res) {
	var body = req.body;
	var fname = body.fname
	var lname = body.lname
	var address = body.address
	var phone = body.phone
	var email = body.email
	var pwd = body.pwd
	var membertype = body.membertype
	var legalinfo = JSON.stringify(body.legalinfo)
	
	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [email,phone,membertype]
			var strsql = "SELECT Email, PhoneNumber FROM users WHERE Email=? AND PhoneNumber=? AND MemberType=?";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> registerTsuper()]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				if (result.length > 0){
					var resultObj = {
						"data": resultdata,
						"status": "001",
						"message": "This account is already registered."
					}
					res.json(resultObj);
				}else{
					step(2)
				}
			}
			});
			break;
		case 2:
			var strval = [fname,lname,email,pwd,address,phone,membertype,legalinfo]
			var strsql = "INSERT INTO users "
						+"(FirstName, LastName, Email, Password,"
						+"CurrentAddress, PhoneNumber, MemberType, LegalProofPhotos,"
						+"Extra1, Extra2, Status) "
						+"VALUES(?,?,?,?,?,?,?,?,'.','.','ACTIVE')";
			mysqltrigger.insertQuery(connection.tsuper_connect, strsql, strval, '[account.js -> registerTsuper()]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				var resultObj = {
					"data": resultdata,
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
	
   // >>>>>>>>>>>>>>>>>> approve 

	

	// >>>>>>>>>>>>>> decline 

}


exports.loginAdminTsuper = function (req, res) {
	var body = req.body;
	var username = body.username
	var pwd = body.pwd

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [username,pwd]
			var strsql = "SELECT * FROM users WHERE Email=? AND Password=? AND MemberType='Admin'";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> loginAdminTsuper()]', function (result) {
			if (result == 'error') {
				var resultObj = {'data': '{}', 'status': 'error', 'message': 'Server Error'};
				res.json(resultObj);
			}else{
				if (result.length <= 0){
					var resultObj = {
						"data": "{}",
						"status": "001",
						"message": "Account does not exist."
					}
					res.json(resultObj);
				}else{
					var resultObj = {
						"data": result[0],
						"status": "000",
						"message": "Success"
					}
					res.json(resultObj);
				}
			}
			});
			break;
		default:
			break;
		}
	}
	step(1);
}

exports.fetchAllUsers = function (req, res) {
	const body = req.body;
	const memberType = body.memberType;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [memberType]
			var strsql = "SELECT * FROM users WHERE MemberType !=? AND MemberType !='Admin'";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> fetchAllUsers()]', function (result) {
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

// >>>>>>>>>>> deleteadmin
exports.deleteUserAdmin = function (req, res) {
	const body = req.body;
	const memberType = body.memberType;
	const id = body.id;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [memberType,id]
			var strsql = "DELETE FROM users WHERE MemberType=? AND ID=?";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> deleteUser()]', function (result) {
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

exports.deleteUser = function (req, res) {
	const body = req.body;
	const memberType = body.memberType;
	const id = body.id;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [memberType,id]
			var strsql = "DELETE FROM users WHERE MemberType=? AND ID=?";
			mysqltrigger.selectAllQuery(connection.tsuper_connect, strsql, strval, '[account.js -> deleteUser()]', function (result) {
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
	step(1);
}

exports.updateUser = function (req, res) {
	const body = req.body;
	const fname = body.fname;
	const lname = body.lname;
	const email = body.email;
	const oldMemberType = body.oldMemberType;
	const memberType = body.memberType;
	const currentAddress = body.currentAddress;
	const id = body.id;

	var resultdata = JSON.stringify({});
	var strval = [fname,lname,email,memberType,currentAddress,oldMemberType,id]
	var strsql = "UPDATE users SET FirstName=?, LastName=?, Email=?, MemberType=?, CurrentAddress=? WHERE MemberType=? AND ID=?";
	mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[account.js -> updateUser()]', function (result) {
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
}

exports.updateProfilePic = function (req, res) {
	const body = req.body;
	const id = body.id;
	const email = body.email;
	const profilePic = body.profilePic;

	var resultdata = JSON.stringify({});
	var strval = [profilePic,email,id]
	var strsql = "UPDATE users SET ProfilePic=? WHERE Email=? AND ID=? LIMIT 1";
	mysqltrigger.updateQuery(connection.tsuper_connect, strsql, strval, '[account.js -> updateUser()]',
	function (result) {
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
}
}