import 'package:flutter/material.dart';
import 'package:tsuperadmin/Components/GlobalVar.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/ChatModel.dart';

import '../../Server/Repo.dart';

part 'Chat_API_Related.dart';
part 'Chat_MsgingView.dart';
part 'Chat_Conversation.dart';
part 'Chat_Conversation_ListView.dart';

class ChatVC extends StatefulWidget {

  @override
  State<ChatVC> createState() => _ChatVC();
}

class _ChatVC extends State<ChatVC> {
  TextEditingController msgTxtController = TextEditingController();

  List<ChatSupportDataModel> allChatSupport = [];
  List<ChatConversationDataModel> allChatConversation = [];
  ChatSupportDataModel? selectedChatSupport;

  @override
  void initState() {
    fetchAdminSupport();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return
    Material(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: 
      Column(
        children: [
          Container(
            color: gkGetColor(PickClr.gkBtnColor),
            height: 70
          ),
          
          Expanded(child: chatMsgVIEWRow())
        ],
      ),
    );
  }

  void refreshState() => setState(() {});
}