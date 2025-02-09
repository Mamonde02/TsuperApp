part of 'BookingDetails.dart';

extension extBookingDetailsHeaderView on _BookingDetails {
  Widget bookingHeaderDesignView(){
    var pickUpArr = [];
    var dropOffArr =[];
    if (widget.confirmationData["TypeService"] == "RoundTrip" || widget.confirmationData["TypeService"] == "DropOff"){
      pickUpArr = widget.confirmationData["PickUp"].split(":::");
      dropOffArr = widget.confirmationData["DropOff"].split(":::");
    }

    return
    Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: bothBoxShadowV1
      ),
      child: Row(
        children: [
          Expanded(child: Text(pickUpArr[0], maxLines: 1, overflow: TextOverflow.ellipsis,)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.arrow_forward, color: gkGetColor(PickClr.tsuperTheme)),
          ),
          Expanded(child: Text(dropOffArr[0], maxLines: 1, overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }

  Widget bookingType(){
    const style1 = TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500);

    return
    Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: gkGetColor(PickClr.tsuperTheme),
        borderRadius: BorderRadius.circular(7),
        boxShadow: bothBoxShadowV1
      ),
      child: Text("$typeOfApplication Booking", style: style1),
    );
  }
}