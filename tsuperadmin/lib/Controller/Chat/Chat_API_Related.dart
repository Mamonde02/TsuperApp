part of 'ChatVC.dart';

extension extChatAPIRelated on _ChatVC {
  void fetchAdminSupport() async {
    Map<String, dynamic> params = {};

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchAdminSupport", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      List<ChatSupportDataModel> decodedData = (jsonData as List).map((e) => ChatSupportDataModel.fromMap(e)).toList();
      decodedData.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });
      allChatSupport = decodedData;
      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void fetchSupportConversation({bool isNeedRefresh = false}) async {
    Map<String,dynamic> params = {
      "supportID": selectedChatSupport?.SupportID.toString(),
      "titleID": selectedChatSupport?.TitleTopic.toString()
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchSupportConversation", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      allChatConversation = (jsonData as List).map((e) => ChatConversationDataModel.fromMap(e)).toList();
      allChatConversation.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });

      if(!mounted) return;
      refreshState();

      if (!isNeedRefresh) return;
      await Future.delayed(const Duration(seconds: 5));
      fetchSupportConversation(isNeedRefresh: isNeedRefresh);
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void sendChatSupport() async {
    final receiverID = selectedChatSupport?.SenderID.toString();
    final supportID = selectedChatSupport?.SupportID.toString();

    Map<String,dynamic> params = {
      "senderid": ".",
      "sendername": ".",
      "topic": selectedChatSupport?.TitleTopic,
      "supportID": supportID,
      "receiverID": receiverID,
      "msg": msgTxtController.text,
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/sendChatSupport", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      msgTxtController.clear();
      fetchSupportConversation(isNeedRefresh: true);
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void updateChatSupportStatus() async {
    Map<String,dynamic> params = {
      "supportID": selectedChatSupport?.SupportID,
      "fromSupport": "1"
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateChatSupportStatus", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}