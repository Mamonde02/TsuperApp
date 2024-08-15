part of 'MatchVC.dart';

extension extMatchDriverPic on _MatchVC {
  Widget driverPicturesView() {
    return
    Container();
  }
  
  Widget carTransmissionDropDown(){
    return
    Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.5),
                    border: Border.all(color: Colors.grey[200]!)
                  ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        hint: Text("Transmission Type",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400])),
        elevation: 2,
        value: carTransmission == "" ? null : carTransmission,
    
        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),
    
        // Array list of items
        items:  
        listCarTransmission.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items, style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),
        
        onChanged: (String? newValue) {
          carTransmission = newValue!;

          if (!mounted) return;
          setState(() {});
        },
      ),
    );
  }
}