part of 'AcceptBooking.dart';

extension extAcceptBookingConfirmBtn on _AcceptBookingVC{

  Widget confirmButton(){
    const style1 = TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500);

    return
    Center(
      child: MaterialButton(
        shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
        color: gkGetColor(PickClr.tsuperTheme),
        elevation: 2.5,
        onPressed: () {
          acceptBookingReqNow();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text("Proceed Request", style: style1),
        ),
      ),
    );
  }
}