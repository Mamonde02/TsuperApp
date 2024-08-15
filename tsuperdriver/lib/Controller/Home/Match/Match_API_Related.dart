part of 'MatchVC.dart';

extension extAPIRelatedMatch on _MatchVC {
  void getMatchUser() async {
    final params = {
      "userID": userData?.ID.toString(),
      "type": userData?.MemberType
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/getMatchUser", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    final data = jsonDecoded["data"];

    if (status == "000"){
      final jsonData = (data as List).map((e) => GetMatchDataModel.fromMap(e)).toList();
      if (jsonData.isEmpty) {
        return;
      }
      matchedDetail = jsonData[0];
      refreshState();

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void startFindMatch(String transmission, String carModel) async {
    final fullName = "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}";
    final params = {
      "userID": userData?.ID.toString(),
      "userName": fullName,
      "transmission": transmission,
      "currentLocation": currentAddress,
      "carModel": carModel
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/startFindMatch", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    final data = jsonDecoded["data"];

    if (status == "000"){
      
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}