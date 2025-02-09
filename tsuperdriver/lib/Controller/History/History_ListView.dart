part of 'HistoryVC.dart';

extension extHistoryListRow on _HistoryVC {
  Widget historyList() {
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);

    return
    ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: allHistory.length,
      itemBuilder: (_,i){
        return
        Container(
          margin: const EdgeInsets.only(bottom: 25, left: 15, right:  15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 0.5),
            boxShadow: bothBoxShadowV1,
            color: Colors.white
          ),
          child: Column(
            children: [
              orderNoVIEW(i),
              dateTimeIn(i),
              
              // spacer(10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12),
              //   child: Row(
              //     children: [
              //       const Text("Service Type : "),
              //       const SizedBox(width: 5),
              //       Expanded(child: Text(allHistory[i].TypeOfService, textAlign: TextAlign.left,style: style1))
              //     ],
              //   ),
              // ),

              spacer(10),
              locationsVIEW(i),
              spacer(10),

              totalAmntDistanceVIEW(i)
            ],
          ),
        );
    });
  }
  
  Widget orderNoVIEW(int i){
    const style1 = TextStyle(fontWeight: FontWeight.w500);
    const style2 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500);

    return
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[400]!)),
        color: statusBG(allHistory[i].Status)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Order No.", style: style1),
          Text(allHistory[i].TransactionNo, style: style2)
        ],
      ),
    );
  }
  
  Widget dateTimeIn(int i){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500);

    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatDateFromDB("MMMM dd, yyyy", allHistory[i].DateTimeIN), style: style1),
          Text(formatDateFromDB("hh:mm aa", allHistory[i].DateTimeIN), style: style1)
        ],
      ),
    );
  }

  Widget totalAmntDistanceVIEW(int i){
    final scfee = (allHistory[i].Status == "BOOKED" || allHistory[i].Status == "COMPLETE") ? allHistory[i].Extra4 ?? "0" : "0";
    final hasFee = (allHistory[i].Status == "BOOKED" || allHistory[i].Status == "COMPLETE");
    return
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[400]!)),
        color: Colors.grey[200]
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          txtStatusVIEW(i),
          Column(
            children: [
              spacer(7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Amount : "),

                  const SizedBox(width: 45),
                  Expanded(child: 
                  Text("Php ${allHistory[i].TotalAmount}${hasFee ? "  +($scfee fee)" : ""}",
                  textAlign: TextAlign.left,))
                ],
              ),
              
              spacer(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Distance : "),
                  const SizedBox(width: 38),
                  Expanded(child: Text("${allHistory[i].Distance} km", textAlign: TextAlign.left,))
                ],
              ),
              spacer(7),
            ],
          ),
        ],
      ),
    );
  }

  Widget locationsVIEW(int i){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400);
    final locationArr = allHistory[i].Locations.split("##");
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
              Expanded(child: Text(locationName[0], style: style1)),
              const SizedBox(width: 5),
            ],
          ),
        );
      }
    );
  }

  Widget txtStatusVIEW(int i){
    var txtColor = allHistory[i].Status == "PENDING" ? Colors.blue[100] : gkGetColor(PickClr.tsuperTheme);
    final style1 = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: txtColor);

    return
    // Text(allHistory[i].Status, style: style1);
    Text("", style: style1);
  }

  Color statusBG(String status) {
    switch (status) {
      case "COMPLETE":
        return Colors.green[300]!;
      case "PENDING":
        return Colors.blue;
      case "CANCELLED":
        return Colors.red;
      default:
        return gkGetColor(PickClr.tsuperTheme);
    }
  }
}