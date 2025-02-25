part of 'EditCon.dart';

// testing only....
extension extEditAPIRelated on _EditVCtwo {
  void updateUser(UserAccountDataModel i) async {
    Map<String, dynamic> params = {
      "fname": fnameTxtController.text.capitalize(),
      "lname": lnameTxtController.text.capitalize(),
      "memberType": selectedMemberType,
      "oldMemberType": i.MemberType,
      "currentAddress": currentAddTxtController.text,
      "email": emailTxtController.text,
      "id": i.ID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateUser", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      if (!mounted) return;
      Navigator.of(context).pop("YES");

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void confirmUser(UserAccountDataModel i) async {
    Map<String, dynamic> params = {
      "id": i.ID
    };
    print("Confirm DISPLAY");

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/confirmUser", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    if (status == "000"){
       print(message);
      if (!mounted) return;
      Navigator.of(context).pop("YES");

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}