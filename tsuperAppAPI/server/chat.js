var express = require("express");
var commonlib = require("./common");
var connection = require('./db/dbconnection');
var mysqltrigger = require('./db/mysqlcontroller');

exports.chatTopic = function (req, res) {
	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = []
			var strsql = "SELECT * FROM chat_topic";
			mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> chatTopic()]', function (result) {
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

exports.fetchSupport = function (req, res) {
	const body = req.body;
	const senderID = body.senderid;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [senderID]
			var strsql = "SELECT * FROM chat_support WHERE SenderID=? ";
			mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> fetchSupport()]', function (result) {
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

exports.fetchSupportConversation = function (req, res) {
	const body = req.body;
	const supportID = body.supportID;
	const titleID = body.titleID;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [supportID,titleID]
			var strsql = "SELECT * FROM chat_conversation WHERE SupportID=? AND TitleTopic=? ";
			mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> fetchSupportConversation()]', function (result) {
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

exports.fetchAdminSupport = function (req, res) {
	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = []
			var strsql = "SELECT * FROM chat_support ";
			mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> fetchAdminSupport()]', function (result) {
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

exports.updateChatSupportStatus = function (req, res) {
	const body = req.body;
	const supportID = body.supportID;
	const fromSupport = body.fromSupport;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [supportID]
			var strsql =  "UPDATE chat_support SET Status='READ' WHERE SupportID=?";
			if (fromSupport == "1"){
				strsql = "UPDATE chat_support SET SupportStatus='READ' WHERE SupportID=?";
			}
			mysqltrigger.updateQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> updateChatSupportStatus()]', function (result) {
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

exports.sendChatSupport = function (req, res) {
	const body = req.body;
	const senderid = body.senderid;
	const sendername = body.sendername;
	const topic = body.topic;
	const supportID = body.supportID;
	const receiverID = body.receiverID;
	const msg = body.msg;

	var resultdata = JSON.stringify({});
    function step(i){
		switch (i) {
		case 1:
			var strval = [supportID,topic];
			var strsql = "SELECT SenderID FROM chat_support WHERE supportID=? AND TitleTopic=?"
			mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> sendChatSupport(1)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					if (result.length == 0){
						step(3);
					}else{
						step(2);
					}
				}
			});
			break;
		case 2:
			var strval = [supportID,topic];
			var strsql = "UPDATE chat_support SET SupportStatus = 'UNREAD',DateTimeIN=Now() WHERE supportID=? AND TitleTopic=?"
			if (senderid == "."){
			 	strsql = "UPDATE chat_support SET Status = 'UNREAD',DateTimeIN=Now() WHERE supportID=? AND TitleTopic=?"
			}
			mysqltrigger.updateQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> sendChatSupport(2)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(4);
				}
			});
			break;
		case 3:
			var strval = [supportID,topic,senderid,sendername]
			var strsql = "INSERT INTO chat_support (DateTimeIN,SupportID,TitleTopic,SenderID,SenderName,Status,SupportStatus) "
						+"Values(Now(),?,?,?,?,'READ','UNREAD')"
			if (senderid == "."){
				strsql = "INSERT INTO chat_support (DateTimeIN,SupportID,TitleTopic,SenderID,SenderName,Status,SupportStatus) "
						 +"Values(Now(),?,?,?,?,'UNREAD','READ')"
			}
			mysqltrigger.insertQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> sendChatSupport(3)]', function (result) {
				if (result == 'error') {
					var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
					res.json(resultObj);
				}else{
					step(4);
				}
			});
			break;
		case 4:
			var strval = [sendername,senderid,receiverID,msg,supportID,topic]
			var strsql = "INSERT INTO chat_conversation (DateTimeIN,SenderName,SenderID,RecieverID,Message,SupportID,TitleTopic) "
						+"Values(Now(),?,?,?,?,?,?)"
			mysqltrigger.insertQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> sendChatSupport(4)]', function (result) {
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

exports.sendMessageMatch = function (req, res) {
	const body = req.body;
	const trxnID = body.trxnID;
	const senderid = body.senderid;
	const receiverID = body.receiverID;
	const type = body.type;
	const msg = body.msg;

	var resultdata = JSON.stringify({});
	var strval = [trxnID,receiverID,msg,senderid]
	var strsql = "INSERT INTO chat_customer_conversation "
				+"(DateTimeIN,TransactionID,ReceiverID,Message,SenderID) "
				+"Values(Now(),?,?,?,?)"
	mysqltrigger.insertQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> sendMessageMatch()]', function (result) {
		if (result == 'error') {
			var resultObj = {'data': resultdata, 'status': 'error', 'message': 'Server Error'};
			res.json(resultObj);
		}else{
			var strval = [trxnID]
			var strsql =  "UPDATE chat_customer SET DriverUNRead='1' WHERE TransactionNo=?";
			if (type == "Driver"){
				strsql = "UPDATE chat_customer SET UNRead='1' WHERE TransactionNo=?";
			}
			mysqltrigger.updateQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> sendMessageMatch(2)]', function (result) {
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
	});
}

exports.insertMatchMsg = function (req, res) {
	const body = req.body;
	const trxnID = body.trxnID;
	const clientName = body.clientName;
	const driverName = body.driverName;
	const Location = body.location;
	const schedule = body.schedule;

	var resultdata = JSON.stringify({});
	var strval = [trxnID,clientName,driverName,Location,schedule]
	var strsql = "INSERT INTO chat_customer "
				+"(DateTimeIN,TransactionNo,ClientName,DriverName,Location,Schedule,Status,UNRead,DriverUNRead) "
				+"Values(Now(),?,?,?,?,?,'ACTIVE','1','1')"
	mysqltrigger.insertQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> insertMatchMsg()]', function (result) {
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

exports.fetchMatchChatList = function (req, res) {
	const body = req.body;
	const username = body.username;
	const type = body.type;

	var resultdata = JSON.stringify({});
	var strval = [username]
	var strsql = "SELECT * FROM chat_customer "
				+"WHERE ClientName = ?"
	if (type == "Driver") {
		strsql = "SELECT * FROM chat_customer "
				+"WHERE DriverName = ?"
	}
	mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> fetchMatchChatList()]', function (result) {
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

exports.fetchMessageMatch = function (req, res) {
	const body = req.body;
	const trxnID = body.trxnID;

	var resultdata = JSON.stringify({});
	var strval = [trxnID]
	var strsql = "SELECT * FROM chat_customer_conversation "
				+"WHERE TransactionID = ?"
	mysqltrigger.selectAllQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> fetchMessageMatch()]', function (result) {
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

exports.updateMatchChatStatus = function (req, res) {
	const body = req.body;
	const trxnID = body.trxnID;
	const type = body.type;

	var resultdata = JSON.stringify({});
	var strval = [trxnID]
	var strsql =  "UPDATE chat_customer SET UNRead='0' WHERE TransactionNo=?";
	if (type == "Driver"){
		strsql = "UPDATE chat_customer SET DriverUNRead='0' WHERE TransactionNo=?";
	}
	mysqltrigger.updateQuery(connection.tsuper_chat, strsql, strval, '[chat.js -> updateMatchChatStatus()]', function (result) {
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