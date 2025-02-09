import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

import '../../../../Components/Colors-Design.dart';
import '../../../../Components/GlobalVar.dart';
import '../../../../Server/Repo.dart';
import '../../../1. CommonUI/PromptModal.dart';
import '../ChatSupport.dart';

part 'Modal_API_Related.dart';
part 'Modal_DropDownTopicType.dart';
part 'Modal_SubmitBtn.dart';

class ModalSubmitChatTopic extends StatefulWidget {
  List<ChatTopicDataModel> allChatTopic = [];

  ModalSubmitChatTopic({super.key, required this.allChatTopic});

  @override
  State<ModalSubmitChatTopic> createState() => _ModalSubmitChatTopic();
}

class _ModalSubmitChatTopic extends State<ModalSubmitChatTopic> {
  TextEditingController msgTxtController = TextEditingController();
  
  ChatTopicDataModel? selectedTopic;

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700);

    return
    GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                titleHeaderVIEW(),
    
                spacer(10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Select Topic", style: style1),
                ),
                spacer(5),
                dropDownContainerVIEW(),
    
                spacer(20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Message", style: style1),
                ),
                spacer(5),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 100,
                  child: TextField(
                    maxLines: 3,
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    controller: msgTxtController,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 15, right: 10),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
                      hintText: "Message Here...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: gkGetColor(PickClr.gkSkyBlue))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: gkGetColor(PickClr.gkSkyBlue))
                      ),
                    ),
                  )
                ),
    
                spacer(15),
                submitBtn(),
                spacer(10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleHeaderVIEW(){
    final style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));

    return
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Text("Contact Chat Support", style: style1),
    
          const Spacer(),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close, color: Colors.grey[300]),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
  
  void refreshState() => setState(() {});
}