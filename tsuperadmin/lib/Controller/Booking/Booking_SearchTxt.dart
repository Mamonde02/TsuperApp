part of 'BookingVC.dart';

extension extSearchTxt on _BookingVC {
  Widget searchTxtView(){
    return
    SizedBox(
      width: 300,
      child: TextField(
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: searchTxtController,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 25, right: 10),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
          hintText: "Search eg: Service Type, Location, Booker Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onChanged: (value){
          if (value.isEmpty){
            displayBookingData = allBookingData;
          }else{
            displayBookingData =  allBookingData.where((e) {
                                    final locations = formatLocations(e.Locations);
                                    return
                                    e.BookerName.toLowerCase().contains(value.toLowerCase()) ||
                                    e.TypeOfService.toLowerCase().contains(value.toLowerCase()) ||
                                    locations.toLowerCase().contains(value.toLowerCase());
                                  }).toList();
          }

          refreshState();
        },
      ),
    );
  }
}