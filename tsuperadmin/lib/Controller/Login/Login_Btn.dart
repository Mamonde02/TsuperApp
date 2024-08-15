part of 'LoginVC.dart';

extension extLoginBtn on _LoginVC {
  Widget signinBtn(){
    final style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));
    return
    Container(
      width: 300,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: bothBoxShadowV1
                  ),
      child: MaterialButton(
        color: Colors.white,
        elevation: 2,
        onPressed: (){
          if (validateIfEmpty()){
            if(!context.mounted) return;
            ToastMessageError.errorMessageV2("All fields are required.", 
              context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
              isShapedBorder: false
            );
            return;
          }
    
          startShowLoadingView();
          loginAdminTsuper();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          child: Text("SIGN IN", style: style1),
        ),
      ),
    );
  }

  bool validateIfEmpty(){
    final admin = adminUserTxt.text;
    final pwd = pwdTxt.text;

    final inputArray = [admin,pwd];
    final isEmpty = inputArray.where((e) => e == "" || e.isEmpty).length;
    return isEmpty > 0 ? true : false;
  }
}