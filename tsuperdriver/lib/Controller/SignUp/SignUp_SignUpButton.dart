part of 'SignUpVC.dart';

extension extSignUpBtn on _SignUpVC {
  Widget signUpButtonVIEW(){
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white);
    final style2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.gkBtnColor));

    return
    Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // SignUP Btn
        signUPBtn(),
        
        spacer(11),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?", style: style1,),

            const SizedBox(width: 5),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Text("Sign in.", style: style2),
            )
          ],
        )
      ],
    );
  }

  Widget signUPBtn(){
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
          onPressed: () async {
            final emailAdd = emailTxtController.text;
            final pwd = pwdTxtController.text;
            final confirmPwd = confirmpwdTxtController.text;
            
            if (validateIfEmpty()){
              if(!context.mounted) return;
              ToastMessageError.errorMessageV2("All fields are required. Please enter required info.", 
                context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                isShapedBorder: false
              );
              return;
            }

            if (!emailAdd.isEmailValid()){
              if(!context.mounted) return;
              ToastMessageError.errorMessageV2("Please enter valid email address.", 
                context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                isShapedBorder: false
              );
              return;
            }

            if (pwd != confirmPwd){
              if(!context.mounted) return;
              ToastMessageError.errorMessageV2("The confirm password does not match.", 
                context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                isShapedBorder: false
              );
              return;
            }

            if (pwd.length < 6){
              if(!context.mounted) return;
              ToastMessageError.errorMessageV2("Password must be atleast 6.", 
                context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                isShapedBorder: false
              );
              return;
            }

            if (selectedMemberType == null) {
              ToastMessageError.errorMessageV2("Please select Member Type between Driver or Car Owner.", 
                context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                isShapedBorder: false
              );
              return;
            }

            if (selectedMemberType == "Car Owner") {
              final arrContent = [carModel,driverLicenseBack,driverLicenseFront];
              for (var e in arrContent) {
                if (e.isEmpty) {
                  ToastMessageError.errorMessageV2("Please upload all required requirements photo.", 
                    context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                    isShapedBorder: false
                  );
                  return;
                }
              }
            } 
            // else {
            //   final arrContent = [driverLicenseBack,driverLicenseFront,validID];
            //   for (var e in arrContent) {
            //     if (e.isEmpty) {
            //       ToastMessageError.errorMessageV2("Please upload all required requirements photo.", 
            //         context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
            //         isShapedBorder: false
            //       );
            //       return;
            //     }
            //   }
            // }

            // export function for validateUser
            //  loginTsuper()     ; 
            // registerTsuper
            

            //ShowLoadingView
            // startShowLoadingView(); // comment as of now 

            // async function request to backend
            registerTsuper();
            
            // bool isValid = await validateIfUserExist();
            // if (isValid){
            //   uploadImage();
            // }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            child: Text("SIGN UP", style: style1),
          ),
        ),
      ),
    );
  }

  bool validateIfEmpty(){
    final fname = fnameTxtController.text;
    final lname = lnameTxtController.text;
    // final currentAdd = currentAddressTxtController.text;
    final phoneNum = phoneNumTxtController.text;
    final emailAdd = emailTxtController.text;
    final pwd = pwdTxtController.text;
    final confirmPwd = confirmpwdTxtController.text;
    final memberType = selectedMemberType ?? "";

    final inputArray = [fname,lname,phoneNum,emailAdd,pwd,confirmPwd,memberType];
    final isEmpty = inputArray.where((e) => e == "" || e.isEmpty).length;
    return isEmpty > 0 ? true : false;
  }
}