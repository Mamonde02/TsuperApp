part of 'EditProfileVC.dart';

extension extAPIRelatd on _EditProfileVC {
  void updateProfilePic(String profilePic) async {
    final params = {
      "email": userData?.Email,
      "id": userData?.ID,
      "profilePic": profilePic
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateProfilePic", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      userData?.ProfilePic = profilePic;
      refreshState();
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString("isAlreadyLoggin", json.encode(userData!.toJson()));
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void updateUser() async {
    final params = {
      "fname": fnameTxtController.text,
      "lname": lnameTxtController.text,
      "email": emailTxtController.text,
      "oldMemberType": userData?.MemberType ?? "",
      "memberType": userData?.MemberType ?? "",
      "currentAddress": currentAddress,
      "phone": phoneNumTxtController.text,
      "id": userData?.ID ?? "",
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateUser", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      userData?.FirstName = fnameTxtController.text;
      userData?.LastName = lnameTxtController.text;
      userData?.Email = emailTxtController.text;
      userData?.CurrentAddress = currentAddressTxtController.text;
      userData?.PhoneNumber = phoneNumTxtController.text;

      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString("isAlreadyLoggin", json.encode(userData!.toJson()));

      if (!mounted) return;
      showPromptModal(context, "success", "Update Successfully")
      .then((value) => {
        Navigator.of(context).pop()
      });
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}