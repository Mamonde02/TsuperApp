var accController = require("./server/account")
var bookingController = require("./server/booking")
var findBookingController = require("./server/findbooking")
var chatController = require("./server/chat")
var matchController = require("./server/match")
var notifController = require("./server/notification")


module.exports = function (app){
	app.post("/api/loginTsuper", function (req, res) {
		accController.loginTsuper(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/validateIfUserExist", function (req, res) {
		accController.validateIfUserExist(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/registerTsuper", function (req, res) {
		accController.registerTsuper(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/insertBooking", function (req, res) {
		bookingController.insertBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/viewHistory", function (req, res) {
		bookingController.viewHistory(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/findBookingList", function (req, res) {
		findBookingController.findBookingList(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/loginAdminTsuper", function (req, res) {
		accController.loginAdminTsuper(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchAllUsers", function (req, res) {
		accController.fetchAllUsers(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchAllBooking", function (req, res) {
		bookingController.fetchAllBooking(req, res, function  (result) {
			res.json(result);
		})
	});
   // >>>>>>>>>>> /// admin checking
    //...>>>

    // >>>>>> modify >>>
	/*
	app.post("/api/approveAdmin", function (req, res) {
		accController.registerTsuper(req, res, function  (result) {
			accCo(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/declinedmin", function (req, res) {
		accController.registerTsuper(req, res, function  (result) {
			accCo(req, res, function  (result) {
			res.json(result);
		})
	});

	// >>> modify code ///
	*/


	app.post("/api/chatTopic", function (req, res) {
		chatController.chatTopic(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchSupport", function (req, res) {
		chatController.fetchSupport(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchSupportConversation", function (req, res) {
		chatController.fetchSupportConversation(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchAdminSupport", function (req, res) {
		chatController.fetchAdminSupport(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/updateChatSupportStatus", function (req, res) {
		chatController.updateChatSupportStatus(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/deleteUser", function (req, res) {
		accController.deleteUser(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/updateUser", function (req, res) {
		accController.updateUser(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/sendChatSupport", function (req, res) {
		chatController.sendChatSupport(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/findPendingBooking", function (req, res) {
		bookingController.findPendingBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/findDriverBookingQueue", function (req, res) {
		findBookingController.findDriverBookingQueue(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/acceptBookingReqNow", function (req, res) {
		findBookingController.acceptBookingReqNow(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/findPendingDriverBookingQueue", function (req, res) {
		findBookingController.findPendingDriverBookingQueue(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/cancelWaitingBooking", function (req, res) {
		findBookingController.cancelWaitingBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/selectDriverReq", function (req, res) {
		findBookingController.selectDriverReq(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/sendMessageMatch", function (req, res) {
		chatController.sendMessageMatch(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchMessageMatch", function (req, res) {
		chatController.fetchMessageMatch(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/rateDriver", function (req, res) {
		matchController.rateDriver(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchReviewRating", function (req, res) {
		matchController.fetchReviewRating(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/checkDriverBookingQueueStatus", function (req, res) {
		findBookingController.checkDriverBookingQueueStatus(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchMatchChatList", function (req, res) {
		chatController.fetchMatchChatList(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/insertMatchMsg", function (req, res) {
		chatController.insertMatchMsg(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/updateMatchChatStatus", function (req, res) {
		chatController.updateMatchChatStatus(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/fetchNotif", function (req, res) {
		notifController.fetchNotif(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/updateNotif", function (req, res) {
		notifController.updateNotif(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/updateIsReceivedNotif", function (req, res) {
		notifController.updateIsReceivedNotif(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/updateProfilePic", function (req, res) {
		accController.updateProfilePic(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/confirmUser", function (req, res) {
		accController.confirmUser(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/specialBooking", function (req, res) {
		bookingController.specialBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/specialBookingList", function (req, res) {
		findBookingController.specialBookingList(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/cancelSpecialBooking", function (req, res) {
		findBookingController.cancelSpecialBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/acceptSpecialBooking", function (req, res) {
		findBookingController.acceptSpecialBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/countSpecialReqBooking", function (req, res) {
		findBookingController.countSpecialReqBooking(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/getMatchUser", function (req, res) {
		matchController.getMatchUser(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/startFindMatch", function (req, res) {
		matchController.startFindMatch(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/startDriverFindMatch", function (req, res) {
		matchController.startDriverFindMatch(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/stopFindMatch", function (req, res) {
		matchController.stopFindMatch(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/matchFound", function (req, res) {
		matchController.matchFound(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/deleteMatchFound", function (req, res) {
		matchController.deleteMatchFound(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/reqBookingMatchFound", function (req, res) {
		matchController.reqBookingMatchFound(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/deleteMatchDriverFound", function (req, res) {
		matchController.deleteMatchDriverFound(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/completeReqMatchFound", function (req, res) {
		matchController.completeReqMatchFound(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/completeEndReqMatchFound", function (req, res) {
		matchController.completeEndReqMatchFound(req, res, function  (result) {
			res.json(result);
		})
	});
	app.post("/api/declineReqMatchFound", function (req, res) {
		matchController.declineReqMatchFound(req, res, function  (result) {
			res.json(result);
		})
	});

};
