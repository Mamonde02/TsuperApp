part of 'ChatSupport.dart';

extension extAPIRelated on _ChatSupportVC {
  
  void chatTopic() async {
    Map<String,dynamic> params = {};

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/chatTopic", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      allChatTopic = (jsonData as List).map((e) => ChatTopicDataModel.fromMap(e)).toList();

      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void fetchSupport() async {
    Map<String,dynamic> params = {
      "senderid": userData?.ID.toString()
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchSupport", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      allSupportMsg = (jsonData as List).map((e) => ChatSupportDataModel.fromMap(e)).toList();

      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void updateChatSupportStatus(String supportID) async {
    Map<String,dynamic> params = {
      "supportID": supportID,
      "fromSupport": "0"
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