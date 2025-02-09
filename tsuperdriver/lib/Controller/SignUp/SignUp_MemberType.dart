part of 'SignUpVC.dart';

extension extMemberType on _SignUpVC {
  Widget dropDownContainerVIEW(){
    return
    Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.5)
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        hint: Text("Select Member Type",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400])),
        elevation: 2,
        value: selectedMemberType == "" ? null : selectedMemberType,
    
        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),
    
        // Array list of items
        items:  
        listOfMemberType.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items, style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),
        
        onChanged: (String? newValue) {
          setState(() {
            selectedMemberType = newValue!;
            // amountListOfRegular();
          });
        },
      ),
    );
  }

  
  Widget carTransmissionDropDown(){
    return
    Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.5)
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        hint: Text("Select Member Type",
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