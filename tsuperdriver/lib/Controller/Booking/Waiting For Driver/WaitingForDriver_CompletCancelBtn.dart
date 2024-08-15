part of 'WaitingForDriver.dart';

extension extCompleteCancelBtn on _WaitingForDriver {
  Widget completeBtn(int i, String statusVal){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: MaterialButton(
          color: Colors.green,
          elevation: 2,
          onPressed: (){
            selectDriverReq(i, statusVal);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.drive_eta_sharp, color: Colors.white,),
                Text(
                  (userData?.MemberType == "Driver") ? 
                  "  I'm Here!" :
                  " Complete", 
                style: style1)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelBtnBookign(){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Expanded(
      child: MaterialButton(
        color: Colors.red,
        elevation: 2,
        onPressed: (){
          cancelWaitingBooking();
        },
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.close, color: Colors.white,),
              Text(
                userData?.MemberType != "Driver" ?
                "Cancel Booking" : "Cancel Request", 
              style: style1)
              
            ],
          ),
        ),
      ),
    );
  }

  
  Widget carefulOnYourTrip(){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Expanded(
      child: MaterialButton(
        color: gkGetColor(PickClr.gkBtnColor).withOpacity(0.2),
        elevation: 2,
        onPressed: (){},
        child: const Padding(
          padding:  EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.car_rental, color: Colors.white,),
              Text("Travelling", 
              style: style1)
            ],
          ),
        ),
      ),
    );
  }
}