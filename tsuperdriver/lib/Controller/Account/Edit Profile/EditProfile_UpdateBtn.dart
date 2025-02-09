part of 'EditProfileVC.dart';

extension extUpdateBtn on _EditProfileVC {
  Widget updateProfileBtn() {
    const style1 = TextStyle(fontSize: 18.5, fontWeight: FontWeight.w700, color: Colors.white);

    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 12.5),
        color: gkGetColor(PickClr.tsuperTheme),
        elevation: 2,
        onPressed: () {            
          if (validateIfEmpty()){
            if(!context.mounted) return;
            ToastMessageError.errorMessageV2("All fields are required. Please enter required info.", 
              context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
              isShapedBorder: false
            );
            return;
          }            
          
          if (!emailTxtController.text.isEmailValid()){
            if(!context.mounted) return;
            ToastMessageError.errorMessageV2("Please enter valid email address.", 
              context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
              isShapedBorder: false
            );
            return;
          }

          updateUser();
        },
        child: const Text("UPDATE", style: style1),
      ),
    );
  }
  
  bool validateIfEmpty(){
    final fname = fnameTxtController.text;
    final lname = lnameTxtController.text;
    // final currentAdd = currentAddressTxtController.text;
    final phoneNum = phoneNumTxtController.text;
    final emailAdd = emailTxtController.text;

    final inputArray = [fname,lname,phoneNum,emailAdd]; // fname,lname,currentAdd
    final isEmpty = inputArray.where((e) => e == "" || e.isEmpty).length;
    return isEmpty > 0 ? true : false;
  }
}