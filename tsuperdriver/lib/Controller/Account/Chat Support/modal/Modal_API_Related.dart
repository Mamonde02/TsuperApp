part of 'Modal_SubmitChatTopic.dart';

extension extAPIRelated on _ModalSubmitChatTopic {
  void sendChatSupport() async {
    final senderName = "${userData?.FirstName.toString()} ${userData?.LastName.toString()}";
    final supportID = "${getDateFromNOW("MMyyyyddhhmmss")}${userData?.ID.toString()}";
    Map<String,dynamic> params = {
      "senderid": userData?.ID.toString(),
      "sendername": senderName,
      "topic": selectedTopic?.TopicName.toString(),
      "supportID": supportID,
      "receiverID": ".",
      "msg": msgTxtController.text,
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/sendChatSupport", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      if(!mounted) return;
      Navigator.of(context).pop("YES");

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}