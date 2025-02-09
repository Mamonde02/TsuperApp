part of 'AcceptBooking.dart';

extension extScheduleDate on _AcceptBookingVC {
  Widget scheduleDateView() {
    const style5 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1);
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
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

            Text("- ${widget.selectedBook.DateStart ?? ""}", style: style5),
            (widget.selectedBook.TypeOfService == "Tour") ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- ${widget.selectedBook.DateEnd ?? ""}", style: style5),
                Text("- ${widget.selectedBook.Days.toString()} Days", style: style5),
              ],
            ) :
            Container(),
            spacer(5),
        ],
      ),
    );
  }
}