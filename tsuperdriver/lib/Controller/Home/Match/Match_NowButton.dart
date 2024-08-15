part of 'MatchVC.dart';

extension extMatchNowButton on _MatchVC {
  Widget matchNowBtn() {
    const style1 = TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500);

    return
    MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      color: Colors.orange,
      onPressed: () {
        if (!findMatchCarOwnerValid()) {
          ToastMessageError.errorMessageV2("Please enter your current location.", 
            context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
            isShapedBorder: false
          );
          return;
        }
        startShowLoadingView();

        if (userData?.MemberType != "Driver") {
          final finalCarModel = matchCarModel ? carModel : "";
          startFindMatch(carTransmission, finalCarModel);
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("Find Match Now", style: style1),
      ),
    );
  }

  bool findMatchCarOwnerValid() {
    if (currentAddress.isEmpty) {
      return false;
    }
    return true;
  }
}