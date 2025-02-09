part of 'AcceptBooking.dart';

extension extAcceptBooking on _AcceptBookingVC {
  Widget locationsPoint(){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400);
    final locationArr = widget.selectedBook.Locations.split("##");
    return
    ListView.builder(
      shrinkWrap: true,
      itemCount: locationArr.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i){
        final locationName = locationArr[i].split(":::");
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
              Text(locationName[0], style: style1),
              const SizedBox(width: 5),
            ],
          ),
        );
      }
    );
  }
}