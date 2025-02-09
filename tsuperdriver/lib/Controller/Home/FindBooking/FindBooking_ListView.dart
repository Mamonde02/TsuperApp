part of 'FindBooking.dart';

extension extFindBookingLISTView on _FindBooking {
  Widget findBookingListVIEW(){
    const style1 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500);

    return
    ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: allAvailableUser.length,
      shrinkWrap: true,
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
              Text("${allAvailableUser[i]?.FirstName ?? ""} ${allAvailableUser[i]?.LastName ?? ""}", style: style1),
            
              spacer(15),
              locationsVIEW(i),
              serviceTypeView(i),
              
              spacer(5),
              legalInfoView(i)
            ],
          ),
        );
    });
  }

  Widget locationsVIEW(int i){
    const style1 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

    return
    Row(
      children: [
        Icon(Icons.pin_drop, color: gkGetColor(PickClr.tsuperTheme), size: 30),

        const SizedBox(width: 15),
        // Expanded(child: Text(allAvailableUser[i]?.CurrentAddress ?? "", style: style1)),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget serviceTypeView(int i){
    final extra2 = allAvailableUser[i]!.Extra2 != "." ? allAvailableUser[i]!.Extra2.toString() : "0";
    final starRating = int.parse(extra2);
    const style1 = TextStyle(fontWeight: FontWeight.w500);
    return
    Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: gkGetColor(PickClr.tsuperTheme)),
            borderRadius: BorderRadius.circular(35)
          ),
          child: Icon(Icons.car_repair_rounded, color: gkGetColor(PickClr.tsuperTheme), size: 25),
        ),
        
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Total Service Drive :"),
            Text(extra2, style: style1)
          ],
        ),
        
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Total Ratings :"),
            starRatingsView(starRating)
          ],
        )
      ],
    );
  }

  Widget legalInfoView(int i){
    var legalInfo = allAvailableUser[i]?.LegalProofPhotos ?? "";
    legalInfo = legalInfo.replaceAll("\\", "").replaceAll("\"{", "{").replaceAll("}\"", "}");
    const style1 = TextStyle(fontWeight: FontWeight.w500);
    return
    Row(
      children: [
        MaterialButton(
          color: gkGetColor(PickClr.gkBtnColor),
          onPressed: (){
            Navigator.of(context).push(
              createRoute(
                DriverReviewsVC(driverInfo: allAvailableUser[i]!)
              )
            );
          },
          child: const Text("Reviews", style: style1),
        ),

        const SizedBox(width: 15),
        MaterialButton(
          color: gkGetColor(PickClr.tsuperTheme),
          onPressed: (){
            specialDriverBook = allAvailableUser[i];
            Navigator.of(context).push(
              createRoute(
                BookingVC(homeTabbarCtrlr: homeTabbarCtrlr, isFromReqBooking: true)
              )
            ).then((value) => {
              specialDriverBook = null
            });
          },
          child: const Text("Request Booking", style: style1),
        ),
      ],
    );
  }
}

Widget starRatingsView(int starRate) {
  return
  SizedBox(
    height: 30,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: starRate,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i){
        if (i <= starRate) {
          return
          Icon(Icons.star, color: gkGetColor(PickClr.tsuperTheme), size: 25);
        }else{
          return
          Icon(Icons.star_border_outlined, color: gkGetColor(PickClr.tsuperTheme), size: 25);
        }
      }
    ),
  );
}