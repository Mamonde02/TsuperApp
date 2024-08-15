part of 'GenerateReportVC.dart';

extension extBookingListView on _GenerateReportVC {
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
      constrained: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 15),
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
          columns: const [
            DataColumn(label: Text('Date Time', style: style1)),
            DataColumn(label: Text('Transaction No', style: style1)),
            DataColumn(label: Text('Driver Name', style: style1)),
            DataColumn(label: Text('Type Of Service', style: style1)),
            DataColumn(label: Text('Price', style: style1)),
          ], 
          rows: 
          List.generate(displayBookingData.length, (i){
            return 
            DataRow(
              cells: [
                DataCell(Text(formatDateFromDB("MM/dd/yyyy hh:mm aa", displayBookingData[i].DateTimeIN))),
                DataCell(Text(displayBookingData[i].TransactionNo.toString())),
                DataCell(Text(displayBookingData[i].Extra3.toString())),
                DataCell(Text(displayBookingData[i].TypeOfService)),
                DataCell(Text("₱ ${convertCurrencyNoSymbol(displayBookingData[i].TotalAmount)}")),
              ]
            );
          }).toList(),
        ),
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