part of 'FindBooking.dart';

extension extReqFindBookingLIST on _FindBooking {
  Widget requestBookingListVIEW(){
    const style1 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500);
    final style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme), height: 1);
    final style3 = TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme), height: 1);
    const style4 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500);

    return
    allHistory.isEmpty ?
    emptyView("No Request Booking Yet.") :
    ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: allHistory.length,
      itemBuilder: (_,i){
        return
        Container(
          margin: const EdgeInsets.only(bottom: 25, left: 15, right:  15),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 1),
                        borderRadius: BorderRadius.circular(7)
                      ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(allHistory[i].BookerName, style: style1),

              spacer(15),
              locationsVIEW1(i),

              spacer(15),
              carModelInfoView1(i),

              spacer(15),
              serviceTypeView1(i),

              spacer(28),
              Text("Client Request", style: style3),

              spacer(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Service Fee :", style: style4),
                  Text("₱ ${allHistory[i].Extra4}", style: style2)
                ],
              ),

              scheduleDateView(i),

              spacer(20),
              bookNowButton(i)
            ],
          ),
        );
    });
  }

  Widget locationsVIEW1(int i){
    const style1 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    final arrLocations = allHistory[i].Locations.split("##");
    final place1 = arrLocations[0].split(":::");
    var place2 = [];
    if (arrLocations.length > 1) {
      place2 = arrLocations[1].split(":::");
    }

    return
    Column(
      children: [
        Row(
          children: [
            dropPickIcon(size: 20),
    
            const SizedBox(width: 15),
            Expanded(child: Text(place1[0], style: style1)),
            const SizedBox(width: 5),
          ],
        ),

        spacer(10),
        arrLocations.length > 1 ?
        Row(
          children: [
            dropPickIcon(size: 20, type: "DropOff"),
    
            const SizedBox(width: 15),
            Expanded(child: Text(place2[0], style: style1)),
            const SizedBox(width: 5),
          ],
        ) : Container(),
      ],
    );
  }

  Widget carModelInfoView1(int i){
    final legalInfo = allHistory[i].Extra1;
    Map<String,dynamic> jsonData = jsonDecode(jsonDecode(legalInfo ?? ""));
    const style1 = TextStyle(fontWeight: FontWeight.w700);
    return
    Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: gkGetColor(PickClr.tsuperTheme)),
            borderRadius: BorderRadius.circular(35)
          ),
          child: Icon(Icons.car_rental, color: gkGetColor(PickClr.tsuperTheme), size: 25),
        ),
        
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Car Model: "),
                Text(jsonData["CarName"].toString(), style: style1)
              ],
            ),
            
            const SizedBox(width: 35),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Car Transmission : "),
                Text(jsonData["Transmission"].toString(), style: style1)
              ],
            )
          ],
        ),
      ],
    );
  }
  
  Widget serviceTypeView1(int i){
    final typeService = allHistory[i].TypeOfService;
    final totalFare = allHistory[i].TotalAmount;
    const style1 = TextStyle(fontWeight: FontWeight.w500);
    final style2 = TextStyle(fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    return
    Row(
      children: [
        typeOfServiceIcon(typeService),
        
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Service Type :"),
            Text(typeService, style: style1)
          ],
        ),
        
        const SizedBox(width: 35),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Total Fare :"),
            Text("₱ ${convertCurrencyNoSymbol(totalFare)}", style: style2)
          ],
        )
      ],
    );
  }

  Widget scheduleDateView(int i) {
    const style5 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1);
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(15),
        const Row(
          children: [
            Icon(Icons.av_timer),
            SizedBox(width: 5),
            Text("Schedule Date: "),
          ],
        ),
        spacer(2),
    
        Text("- ${allHistory[i].DateStart ?? ""}", style: style5),
        (allHistory[i].TypeOfService == "Tour") ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("- ${allHistory[i].DateEnd ?? ""}", style: style5),
            Text("- ${allHistory[i].Days.toString()} Days", style: style5),
          ],
        ) :
        Container(),
        spacer(5),
      ],
    );
  }
}