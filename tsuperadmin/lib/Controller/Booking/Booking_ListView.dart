part of 'BookingVC.dart';

extension extBookingListView on _BookingVC {
  Widget bookingListVIEW(){
    return
    Expanded(
      child: columnHeaderView(),
    );
  }

  Widget columnHeaderView(){
    const style1 = TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w700);
    final style2 = TextStyle(fontSize: 15, color: gkGetColor(PickClr.tsuperTheme), fontWeight: FontWeight.w700);

    return
    InteractiveViewer(
      scaleEnabled: false,
      constrained: false,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('ID', style: style1)),
          const DataColumn(label: Text('TransactionNo', style: style1)),
          const DataColumn(label: Text('DateTimeIN', style: style1)),
          const DataColumn(label: Text('Locations', style: style1)),
          const DataColumn(label: Text('TotalAmount', style: style1)),
          const DataColumn(label: Text('Distance', style: style1)),
          const DataColumn(label: Text('BookerName', style: style1)),
          const DataColumn(label: Text('BookerID', style: style1)),
          const DataColumn(label: Text('TypeOfService', style: style1)),
          const DataColumn(label: Text('Driver', style: style1)),
          DataColumn(label: Text('Status', style: style2)),
        ], 
        rows: 
        List.generate(displayBookingData.length, (i){
          return 
          DataRow(
            cells: [
              DataCell(Text(displayBookingData[i].ID.toString())),
              DataCell(Text(displayBookingData[i].TransactionNo.toString())),
              DataCell(Text(formatDateFromDB("MM/dd/yyyy hh:mm aa", displayBookingData[i].DateTimeIN.toString()))),
              DataCell(Text(formatLocations(displayBookingData[i].Locations))),
              DataCell(Text("₱ ${convertCurrencyNoSymbol(displayBookingData[i].TotalAmount)}")),
              DataCell(Text("${displayBookingData[i].Distance} km")),
              DataCell(Text(displayBookingData[i].BookerName.toString())),
              DataCell(Text(displayBookingData[i].BookerID.toString())),
              DataCell(Text(displayBookingData[i].TypeOfService.toString())),
              DataCell(Text(displayBookingData[i].Extra3.toString())),
              DataCell(formatStatusVIEW(displayBookingData[i].Status)),
            ]
          );
        }).toList(),
      ),
    );
  }

  Widget formatStatusVIEW(String status){
    switch (status) {
      case "PENDING":
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: gkGetColor(PickClr.gkBtnColor),
          child: Text(status, style: const TextStyle(color: Colors.white))
        );
      case "COMPLETE":
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: Colors.green,
          child: Text(status, style: const TextStyle(color: Colors.white))
        );
      case "CANCELLED":
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: Colors.red,
          child: Text(status, style: const TextStyle(color: Colors.white))
        );
      default:
        return
        Container(
          color: gkGetColor(PickClr.gkBtnColor),
          child: Text(status, style: TextStyle(color: Colors.white))
        );
    }
  }
}