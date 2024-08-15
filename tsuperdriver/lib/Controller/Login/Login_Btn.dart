part of 'LoginVC.dart';

extension extLoginBtn on _LoginVC {
  Widget signinBtn(){
    final style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Container(
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
            loginTsuper();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            child: Text("SIGN IN", style: style1),
          ),
        ),
      ),
    );
  }

  bool validateIfEmpty(){
    final email = emailTxt.text;
    final pwd = pwdTxt.text;

    final inputArray = [email,pwd];
    final isEmpty = inputArray.where((e) => e == "" || e.isEmpty).length;
    return isEmpty > 0 ? true : false;
  }
}