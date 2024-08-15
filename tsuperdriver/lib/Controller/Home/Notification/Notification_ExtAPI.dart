part of 'Notification.dart';

extension extAPI on _Notification {
  void updateNotif(String ID) async {
    final params = {
      "userID": userData?.ID.toString(),
      "ID": ID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateNotif", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    if (status == "000"){

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}