part of 'WaitingForDriver.dart';

extension extDriverListView on _WaitingForDriver {
  Widget driverListView(){
    return
    SizedBox(
      height: pendingBookingInfo?.Status == "BOOKED" ? 157 : 80,
      child: 
      (driverQueue.isEmpty) ?
      lookingForDriverView() :

      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: driverQueue.length,
        itemBuilder: (_, i){
          return
          Column(
            children: [
              driverDisplayDesignView(i, driverQueue[i]),
            ],
          );
        }
      ),
    );
  }

  Widget driverDisplayDesignView(int index, DriverBookingQueueDataModel i){
    final style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));

    return
    Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 7.5),
      padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: bothBoxShadowV1
      ),

      child: Row(
        children: [
          driverPhotoVIEW(i.ProfilePic),
      
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(i.DriverName, style: style1, maxLines: 1, overflow: TextOverflow.ellipsis,),
                
                spacer(5),
                const Text("Service Fee:", style: TextStyle(fontWeight: FontWeight.w500)),
                Text("₱ ${convertCurrencyNoSymbol(i.ServiceFee)}")
              ],
            ),
          ),
          
          const SizedBox(width: 20),  
          (i.Status == "PENDING") ?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  insertMatchMsg(index);
                  selectDriverReq(index, "BOOKED");
                },
                child: const Icon(Icons.check_circle_outline, color: Colors.green, size: 35)
              ),
      
              InkWell(
                onTap: (){
                  cancelWaitingBooking(isDecline: true, i: index);
                },
                child: const Icon(Icons.delete_forever_rounded, color: Colors.red, size: 35)
              )
            ],
          ) : Container()
        ],
      ),
    );
  }

  Widget driverPhotoVIEW(String photo) {
    return
    (photo.isEmpty) ?
    const Icon(Icons.person, size: 50) :
    Container(
      height: 50, width: 50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25)
      ),
      child: Image.network(photo, fit: BoxFit.fill),
    );
  }

  Widget lookingForDriverView(){
    final style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));

    return
    Column(
      children: [
        (pendingBookingInfo?.Status == "BOOKED") ?
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: driverDisplayDesignView(0, pendingDriverBookingInfo!),
        ) : Container(),
    
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/login/movingCar.gif",
              height: 25.0,
              width: 150.0,
              fit: BoxFit.fitWidth,
            ),
            
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                (pendingBookingInfo?.Status == "BOOKED") ? 
                  (pendingDriverBookingInfo?.Status == "BOOKED") ?
                  "Enjoy your travel. Please be careful.":
                  "Your Driver is Arriving. Please wait..." :
                "Waiting for Drivers...", 
              style: style1),
            ),
          ],
        ),
      ],
    );
  }
}