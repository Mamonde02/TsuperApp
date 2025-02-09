part of 'ChatConversation.dart';

extension extConverationAPIRelated on _ChatConversation {
  void fetchSupportConversation({bool isNeedRefresh = false}) async {
    Map<String,dynamic> params = {
      "supportID": widget.supportMsgTopic.SupportID.toString(),
      "titleID": widget.supportMsgTopic.TitleTopic.toString()
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
    final senderName = widget.supportMsgTopic.SenderName.toString();
    final supportID = widget.supportMsgTopic.SupportID.toString();

    Map<String,dynamic> params = {
      "senderid": userData?.ID.toString(),
      "sendername": senderName,
      "topic": widget.supportMsgTopic.TitleTopic,
      "supportID": supportID,
      "receiverID": ".",
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
}