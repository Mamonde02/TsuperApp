part of 'BookingVC.dart';

extension extCalendarBooking on _BookingVC {
  Widget calendarVIEW(String lbl){
    const style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

    return
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(lbl),

        GestureDetector(
          onTap: () async{
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(3000),
            );

            if (pickedDate != null){
              if (lbl == "From :"){
                fromSelecteDate = pickedDate;
              } else {
                toSelecteDate = pickedDate;
              }
              await showTimePickerModal(lbl);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: gkGetColor(PickClr.tsuperTheme)),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              (lbl == "From :") ? 
              formatDateTimeFromDatePicker("dd MMM | hh:mm aa", fromSelecteDate) :
              formatDateTimeFromDatePicker("dd MMM | hh:mm aa", toSelecteDate), 
              style: style1
            ),
          ),
        )
      ],
    );
  }
  Future<DateTime?> showTimePickerModal(String lbl) async{
    final timeDay =  TimeOfDay.fromDateTime((lbl == "From :") ? fromSelecteDate : toSelecteDate);
    final pickedDate = await showTimePicker(
      context: context, 
      initialTime: timeDay
    );
    
    if (pickedDate != null){
      if (lbl == "From :"){
        fromSelecteDate = DateTime(
          fromSelecteDate.year, fromSelecteDate.month, 
          fromSelecteDate.day, pickedDate.hour, pickedDate.minute
        );
      } else {
        toSelecteDate = DateTime(
          toSelecteDate.year, toSelecteDate.month, 
          toSelecteDate.day, pickedDate.hour, pickedDate.minute
        );
      }
      refreshState();
    }
    return null;
  }
}