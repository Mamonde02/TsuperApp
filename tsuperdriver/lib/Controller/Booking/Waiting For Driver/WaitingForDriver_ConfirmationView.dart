part of 'WaitingForDriver.dart';

extension extWaitingConfirmatioNView on _WaitingForDriver {
  Widget confirmationView(){
    final style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    const style2 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
    final style3 = TextStyle(fontSize: 18.5, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));

    return
    Container(
      decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.5), topRight:  Radius.circular(5.5))
                  ),

      child: Column(
        children: [
          spacer(10),
          
          userData?.MemberType == "Driver" ? 
          Column(
            children: [
              Image.asset(
                "assets/login/movingCar.gif",
                height: 25.0,
                width: 150.0,
                fit: BoxFit.fitWidth,
              ),
              spacer(3.5),
              Text(
                pendingDriverBookingInfo?.Status == "ARRIVING"? 
                "Arriving to your Client." : 
                pendingDriverBookingInfo?.Status == "BOOKED"? 
                "Please be careful on your trip." :
                "Waiting for Client to Accept...", 
              style: style1),

              spacer(12),
              Text(pendingBookingInfo?.BookerName ?? "", style: style3),
              Text("Booking ID: ${pendingBookingInfo?.TransactionNo.toString()}", style: style2)
            ],
          ) :

          Column(
            children: [
              Text(driverQueue.isEmpty ? "" : "Driver Found", style: style1),
              spacer(10),

              driverListView(),
            ],
          ),

          spacer(25),
          serviceTypeView(),

          spacer(5),
          locationListView(),

          const Divider(),
          totalFareView(),
          
          spacer(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
              (userData?.MemberType == "Driver" && pendingDriverBookingInfo?.Status == "BOOKED") ?
              carefulOnYourTrip() :
              Row(
              children: [
                (userData?.MemberType != "Driver" && pendingDriverBookingInfo?.Status == "BOOKED") ?
                completeBtn(0, "COMPLETE") :

                (userData?.MemberType == "Driver" && pendingDriverBookingInfo?.Status == "ARRIVING") ? 
                completeBtn(0, "ARRIVED") :
                Container(),

                (pendingDriverBookingInfo?.Status == "BOOKED") ?
                Container() :
                cancelBtnBookign(),
              ],
            ),
          ),
          spacer(15),
        ],
      ),
    );
  }

  Widget locationListView(){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400);
    return
    SizedBox(
      height: locations.length <= 3 ? 58 : 120,
      child: ListView.builder(
        shrinkWrap:  false,
        itemCount: locations.length,
        itemBuilder: (_, i){
          final arrLocationName = locations[i].split(":::");
          final locationName = pendingBookingInfo?.TypeOfService == "Tour" ? arrLocationName[0].split(",") : arrLocationName;
          var isEven = i.isEven;
          return
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 15),
            child: Row(
              children: [
                const SizedBox(width: 10),
                isEven ?
                dropPickIcon(size: 20) :
                dropPickIcon(size: 20, type: "DropOff"),
              
                const SizedBox(width: 10),
                Expanded(child: Text(locationName[0], style: style1)),
                const SizedBox(width: 5),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget totalFareView(){
    final style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    return
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: gkGetColor(PickClr.tsuperTheme)))
          ),
          child: Row(
            children: [
              const SizedBox(width: 5),
              const Text("Total Fare:"),

              const SizedBox(width: 5),
              Text("₱ ${convertCurrencyNoSymbol(pendingBookingInfo?.TotalAmount ?? 0.0)}", style: style1),
              const SizedBox(width: 5),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            const Text("Distance:"),
            const SizedBox(width: 5),
            Text("${pendingBookingInfo?.Distance ?? 0.0} km")
          ],
        ),
      ],
    );
  }
}

Widget serviceTypeView(){
  const style1 = TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500);

  return
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 10),

      Text(pendingBookingInfo?.TypeOfService ?? "", style: style1),

      const SizedBox(width: 10),
      Expanded(
        child: Container(
          height: 1.5,
          color: Colors.grey[300],
        ),
      )
    ],
  );
}

Widget rateDriverView(){
  const style1 = TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500);

  return
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 10),

      Text(
        userData?.MemberType == "Driver" ? 
        "Driver Info" : 
        "Rate Driver", 
      style: style1),

      const SizedBox(width: 10),
      Expanded(
        child: Container(
          height: 1.5,
          color: Colors.grey[300],
        ),
      )
    ],
  );
}