part of 'Edit.dart';

extension extMemberType on _EditVC {
  Widget dropDownContainerVIEW(){
    return
    Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: gkGetColor(PickClr.gkSkyBlue))
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
        
        onChanged: (String? newValue) async{
          selectedMemberType = newValue!;
          refreshState();
        },
      ),
    );
  }
}

