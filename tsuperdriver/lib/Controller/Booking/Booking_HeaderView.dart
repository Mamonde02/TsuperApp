part of 'BookingVC.dart';

extension extHomeHeaderView on _BookingVC {
  Widget headerTitleView(){
    const style1 = TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700);
    const style2 = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);

    return
    Container(
      height: 55,
      color: gkGetColor(PickClr.tsuperTheme),
      child: 
      const Row(
        children: [
           SizedBox(width: 15),
           Text("Booking", style: style1),
      
           Spacer(),
          // const SizedBox(width: 15),
          // TextButton(
          //   onPressed: (){
          //     // showBookingConfirmationModal(confirmationData);
          //   }, 
          //   child: const Text("Done", style: style2)
          // ),
          // const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget bookNowButton(){
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
          const defaultPick = "Search Pickup Location:::0:::0";
          const defaultDrop = "Search Drop-off Location:::0:::0";
          switch (selectedService) {
            case "DropOff":
              if (pickupPlace == defaultPick || dropOffPlace == defaultDrop) {
                ToastMessageError.errorMessageV2("Please select or pick your destination place.", 
                  context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                  isShapedBorder: false
                );
                return;
              }
            case "RoundTrip":
              if (pickupPlace == defaultPick || dropOffPlace == defaultDrop) {
                ToastMessageError.errorMessageV2("Please select or pick your destination place.", 
                  context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                  isShapedBorder: false
                );
                return;
              }
            default:
              if (locations.isEmpty) {
              ToastMessageError.errorMessageV2("Please select or pick your destination place.", 
                context,  offSetBy: 0, position: const StyledToastPosition1(align: Alignment.topCenter, offset: 100.0), 
                isShapedBorder: false
              );
              return;
              }
          }
          
          if (serviceFeeTxtController.text.isNotEmpty) {
            specialServiceFee = double.parse(serviceFeeTxtController.text);
          }
          Map<String, dynamic> confirmationData = {};
          confirmationData["DateStart"] = formatDateTimeFromDatePicker("dd MMM, yyyy | hh:mm aa", fromSelecteDate);
          confirmationData["DateEnd"] = formatDateTimeFromDatePicker("dd MMM, yyyy | hh:mm aa", toSelecteDate);
          confirmationData["Days"] = daysBetween(fromSelecteDate, toSelecteDate);
          confirmationData["TypeService"] = selectedService;
          confirmationData["PickUp"] = pickupPlace;
          confirmationData["DropOff"] = dropOffPlace;
          confirmationData["Locations"] = locations;
          
          Navigator.of(context).push(
            createRoute(
              BookingDetails(
                confirmationData: confirmationData, 
                locations: locations,
              )
            )
          ).then((value) => {
            if (value == "COMPLETE"){
              selectedService = "DropOff",
              pickupPlace = "Search Pickup Location:::0:::0",
              dropOffPlace = "Search Drop-off Location:::0:::0",
              pickTxtController.clear(),
              dropOffTxtController.clear(),
              locations = [],
              refreshState()
            }
          });
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text("Proceed Payment", style: style1),
        ),
      ),
    );
  }

  
  Widget enterServiceFee(){
    return
    Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top:  10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Service Fee (Optional):"),
      
          spacer(2),
          TextField(
            cursorColor: Colors.black,
            textAlign: TextAlign.start,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: serviceFeeTxtController,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 25, right: 10),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
              hintText: "Optional",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: gkGetColor(PickClr.tsuperTheme)),
                              ),
              enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: gkGetColor(PickClr.tsuperTheme)),
                              ),
            ),
          ),
          spacer(15),
        ],
      ),
    );
  }
}