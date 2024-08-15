part of 'GenerateReportVC.dart';

extension extDropDown on _GenerateReportVC {
  Widget dropDownContainerVIEW({bool isValueType = false, bool isActive = true}){
    return
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isActive ? 
            Colors.white : 
            Colors.grey[300],
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: gkGetColor(PickClr.gkSkyBlue))
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        hint: Text(type == "Weekly" ? "7 days from now" : "-",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400])),
        elevation: 2,
        value: !isValueType ? 
        type : 
        valtype,
    
        // Down Arrow Icon
        icon: type == "Weekly" ? null : 
        Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),
    
        // Array list of items
        items:  
        isValueType ?
        arrVal.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items, style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList() : 
        arrType.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items, style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),
        
        onChanged: (String? newValue) async{
          displayBookingData = [];
          displayBookingData.addAll(widget.allBookingData);

          if (!isValueType) {
            type = newValue ?? "";
            valtype = null;
            switch (newValue) {
              case "Daily":
                arrVal = [];
                isHasValType = false;
                dateNeeded = getDateFromNOW("MM/dd/yyyy");
                filterDisplayDate("MM/dd/yyyy", dateNeeded);
                break;
                
              case "Weekly":
                arrVal = [];
                isHasValType = false;
                var now = DateTime.now();
                var now_1w = now.subtract(const Duration(days: 7));
                displayBookingData = displayBookingData.where((e) {
                  final date = DateTime.parse(e.DateTimeIN);
                  return now_1w.isBefore(date);
                }).toList();
                break;

              case "Monthly":
                isHasValType = true;
                arrVal = months();
                valtype = getDateFromNOW("MMMM");
                dateNeeded = "${returnMonthVal(valtype!)}${getDateFromNOW("/yyyy")}";
                filterDisplayDate("MM/yyyy", dateNeeded);
                break;

              case "Annual":
                isHasValType = true;
                arrVal = year();
                valtype = arrVal[0];
                filterDisplayDate("yyyy", valtype!);
                break;
              default:
            }
      
          } else {
            valtype = newValue ?? "";
            switch (type) {
              case "Monthly":
                dateNeeded = "${returnMonthVal(valtype!)}${getDateFromNOW("/yyyy")}";
                filterDisplayDate("MM/yyyy", dateNeeded);
                break;
  
              case "Annual":
                filterDisplayDate("yyyy", valtype!);
                break;
              default:
            }
          }

          totalRevenue = 0;
          for (var e in displayBookingData) {
            totalRevenue += e.TotalAmount;
          }
          refreshState();
        },
      ),
    );
  }

  void filterDisplayDate(String dateFormat, String dateNeeded){
    displayBookingData.removeWhere((e) {
      final date = formatDateFromDB(dateFormat, e.DateTimeIN);
      if (date != dateNeeded) {
        return true;
      }
      return false;
    });
  }
}