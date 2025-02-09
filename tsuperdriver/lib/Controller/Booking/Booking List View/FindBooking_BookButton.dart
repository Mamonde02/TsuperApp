part of 'FindBooking.dart';

extension extFindBookButton on _FindBooking {
  Widget bookNowButton(int i){
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
          final booked = allHistory[i];
          Navigator.of(context).push(createRoute(AcceptBookingVC(selectedBook: allHistory[i])))
          .then((value) => {
            if (value == "APPLY"){
              pendingBookingInfo = FindBookingHistoryDataModel(
                booked.TransactionNo, booked.DateTimeIN, booked.Locations,
                booked.TotalAmount, booked.DateStart, booked.DateEnd, booked.Days,
                booked.Distance, booked.PaymentMethod,
                booked.BookerName, booked.BookerID, booked.TypeOfService, booked.Remarks,
                booked.Status, booked.Extra1, booked.Extra2, booked.Extra3, booked.Extra4
              ),

              refreshState()
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          child: Text(typeOfApplication == "Driver" ? "Accept Request" : "Book Now", style: style1),
        ),
      ),
    );
  }
}