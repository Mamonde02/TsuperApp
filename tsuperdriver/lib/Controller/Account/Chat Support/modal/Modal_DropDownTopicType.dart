part of 'Modal_SubmitChatTopic.dart';

extension extDropDownTopic on _ModalSubmitChatTopic {
  Widget dropDownContainerVIEW(){
    return
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
        hint: Text("Select Support Topic",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400])),
        elevation: 2,
        value: selectedTopic,
    
        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),
    
        // Array list of items
        items:  
        widget.allChatTopic.map((ChatTopicDataModel items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.TopicName, style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),
        
        onChanged: (ChatTopicDataModel? newValue) async{
          selectedTopic = newValue;
          refreshState();
        },
      ),
    );
  }
}