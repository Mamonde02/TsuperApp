import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';

import '../../../../Model/ChatModel.dart';
import '../../../../Server/Repo.dart';
import '../../../1. CommonUI/PromptModal.dart';

part 'ChatConversation_API_Related.dart';
part 'ChatConversation_ListView.dart';
part 'ChatConversation_SendMsgBtn.dart';

class ChatConversation extends StatefulWidget {
  ChatSupportDataModel supportMsgTopic;

  ChatConversation({super.key, required this.supportMsgTopic});
  
  @override
  State<StatefulWidget> createState() => _ChatConversation();
}

class _ChatConversation extends State<ChatConversation> {
  TextEditingController msgTxtController = TextEditingController();

  List<ChatConversationDataModel> allChatConversation = [];

  @override
  void initState() {
    fetchSupportConversation(isNeedRefresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: backNavigation(context, widget.supportMsgTopic.TitleTopic),
        body: 
        Column(
          children: [
            chatConversationListView(),
            sendConversationBtn()
          ],
        ),
      ),
    );
  }

  void refreshState() => setState(() {});
}