part of 'ChatConversationVC.dart';

extension extConverationAPIRelated on _ChatConversationVC {
  void fetchMessageMatch({bool isNeedRefresh = false}) async {
    Map<String,dynamic> params = {
      "trxnID": widget.txnID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchMessageMatch", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      if (jsonData == null) {
        return;
      }

      allChatConversation = (jsonData as List).map((e) => MatchChatConversationDataModel.fromMap(e)).toList();
      allChatConversation.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });

      if(!mounted) return;
      refreshState();

      if (!isNeedRefresh) return;
      await Future.delayed(const Duration(seconds: 5));
      fetchMessageMatch(isNeedRefresh: isNeedRefresh);
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void sendMessageMatch() async {
    var reciverID = "";
    if (userData?.MemberType == "Driver") {
      reciverID = pendingBookingInfo?.BookerID ?? "";
    } else {
      reciverID = pendingDriverBookingInfo?.DriverID.toString() ?? "";
    }

    Map<String,dynamic> params = {
      "trxnID": widget.txnID,
      "senderid": userData?.ID.toString(),
      "type": userData?.MemberType ?? ".",
      "receiverID": reciverID,
      "msg": msgTxtController.text,
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/sendMessageMatch", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      msgTxtController.clear();
      fetchMessageMatch(isNeedRefresh: true);
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}