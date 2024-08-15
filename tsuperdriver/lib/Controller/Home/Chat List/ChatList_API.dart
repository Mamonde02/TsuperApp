part of 'ChatListVC.dart';

extension extAPIRelated on _ChatListVC {
  void fetchMatchChatList() async {
    Map<String,dynamic> params = {
      "username": "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}",
      "type": userData?.MemberType ?? "."
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchMatchChatList", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      allChat = (jsonData as List).map((e) => MatchChatListDataModel.fromMap(e)).toList();
      allChat.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });

      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void updateMatchChatStatus(String txnID) async {
    Map<String,dynamic> params = {
      "trxnID": txnID,
      "type": userData?.MemberType ?? "."
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateMatchChatStatus", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}