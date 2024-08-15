part of 'GenerateReportVC.dart';

extension extRevenueView on _GenerateReportVC {
  Widget revenueView(){
    const style1 = TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w700);
    const style2 = TextStyle(fontSize: 15, color: Colors.transparent, fontWeight: FontWeight.w700);
    return
    Container(
      decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!, width: 3)
                    )
                  ),
      child: InteractiveViewer(
        scaleEnabled: false,
        constrained: true,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
          columns: const [
            DataColumn(label: Text('Revenue', style: style1)),
            DataColumn(label: Text('Date Time', style: style2)),
            DataColumn(label: Text('Driver Name', style: style2)),
            DataColumn(label: Text('Type Of Service', style: style2)),
            DataColumn(label: Text('Price', style: style2)),
          ], 
          rows: 
          List.generate(1, (i){
            return 
            DataRow(
              cells: [
                const DataCell(Text("")),
                DataCell(Text("Total Number of Bookings : ${displayBookingData.length}")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(Text("₱ ${convertCurrencyNoSymbol(totalRevenue)}")),
              ]
            );
          }).toList(),
        ),
      ),
    );
  }
}