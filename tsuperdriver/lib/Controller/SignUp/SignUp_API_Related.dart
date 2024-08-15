part of 'SignUpVC.dart';

extension extAPIRelated on _SignUpVC {
  void dismissLoadingView(){
    Navigator.of(context).pop();
  }

  Future<bool> validateIfUserExist() async {
    final params = {
      "phone": phoneNumTxtController.text,
      "email": emailTxtController.text,
      "membertype": typeOfApplication
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/validateIfUserExist", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status != "000"){
      dismissLoadingView();
      if (!mounted) return false;
      showPromptModal(context, "error", message);
      return false;
    }
    return true;
  }

  void registerTsuper(Map<String, dynamic> legalInformations) async {
    final pwd = pwdTxtController.text.getSha1();
    final params = {
      "fname": fnameTxtController.text,
      "lname": lnameTxtController.text,
      "address": currentAddress,
      "phone": phoneNumTxtController.text,
      "email": emailTxtController.text,
      "pwd": pwd,
      "membertype": selectedMemberType,
      "legalinfo": legalInformations
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/registerTsuper", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      if (!mounted) return;
      showPromptModal(context, "success", "Successfully Registered!")
      .then((value) => {
        Navigator.of(context).pop()
      });
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  Future createUserEmail(Map<String, dynamic> legalInfo) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTxtController.text, 
        password: pwdTxtController.text
      );

      dismissLoadingView();
      sendEmailVerfication(legalInfo);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future sendEmailVerfication(Map<String, dynamic> legalInfo) async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    
    showEmailVerification(legalInfo);
  }
  
  void showEmailVerification(Map<String, dynamic> legalInfo) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return 
        FirebaseEmailVerification(
          email: emailTxtController.text,
          legalInfo: legalInfo,
        );
      },
    ).then((value) => {
      if (value != null) {
        if (value == "Verified") {
          registerTsuper(legalInfo)
        }
      }
    });
  }
}
