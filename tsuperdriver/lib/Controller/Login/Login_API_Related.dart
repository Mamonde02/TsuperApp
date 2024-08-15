part of 'LoginVC.dart';

extension extLoginAPIRelated on _LoginVC {
  void dismissLoadingView(){
    Navigator.of(context).pop();
  }
  
  void loginTsuper() async {
    final pwd = pwdTxt.text.getSha1();
    final params = {
      "email": emailTxt.text,
      "pwd": pwd,
      "membertype": typeOfApplication,
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/loginTsuper", {}, params);

    print(jsonDecoded);

    dismissLoadingView();
    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      Map<String, dynamic> jsonData = jsonDecoded["data"];
      userData = UserAccountDataModel.fromMap(jsonData);

      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString("isAlreadyLoggin", jsonEncode(jsonData));

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        createRoute(const HomeTabbarVC())
      );
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}