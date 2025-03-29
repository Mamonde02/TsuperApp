part of 'UsersVC.dart';

extension extUsersAPIRelated on _UsersVC {
  void fetchAllUsers() async {
    Map<String, dynamic> params = {
      "memberType": "Admin"
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchAllUsers", {}, params);
    
    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      List<UserAccountDataModel> decodedData = (jsonData as List).map((e) => UserAccountDataModel.fromMap(e)).toList();

      allUsersData = decodedData;
      displayedUsersData = decodedData;
      filteredUsers = decodedData;
      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void deleteUser(UserAccountDataModel i) async {
    Map<String, dynamic> params = {
      "memberType": i.MemberType,
      "id": i.ID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/deleteUser", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      allUsersData.removeWhere((element) {
        return
        element.ID == i.ID;
      });

      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}