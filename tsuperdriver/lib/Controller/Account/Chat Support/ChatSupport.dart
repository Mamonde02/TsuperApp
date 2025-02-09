import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';
import 'package:tsuperdriver/Controller/Account/Chat%20Support/Chat%20Conversation/ChatConversation.dart';
import 'package:tsuperdriver/Controller/Account/Chat%20Support/modal/Modal_SubmitChatTopic.dart';

import '../../../Model/ChatModel.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/EmptyView.dart';
import '../../1. CommonUI/PromptModal.dart';

part 'ChatSupport_SubmitBtn.dart';
part 'ChatSupport_API_Related.dart';
part 'ChatSupport_ListView.dart';

class ChatSupportVC extends StatefulWidget {
  const ChatSupportVC({super.key});


  @override
  State<StatefulWidget> createState() => _ChatSupportVC();
}

class _ChatSupportVC extends State<ChatSupportVC> {

  List<ChatTopicDataModel> allChatTopic = [];
  List<ChatSupportDataModel> allSupportMsg = [];

  @override
  void initState() {
    chatTopic();
    fetchSupport();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: backNavigation(context, "Support"),
      backgroundColor: gkGetColor(PickClr.gkBGStyle2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          allSupportMsg.isEmpty ?
          Expanded(child: emptyView("NO SUPPORT CASE YET")) :
          chatSupportListView(),

          submitBtn()
        ],
      ),
    );
  }

  Future<Object?> showNewChatTopicPromptModal(){
    return 
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      return 
      ModalSubmitChatTopic(
        allChatTopic: allChatTopic,
      );
    }).then((value) => {
      if (value == "YES") {
        fetchSupport()
      }
    });
  }

  void refreshState() => setState(() {});
}

class ChatTopicDataModel {
  int ID;
  String TopicName;

  ChatTopicDataModel(this.ID, this.TopicName);
  
  factory ChatTopicDataModel.fromMap(Map<String, dynamic> data) {
    return
    ChatTopicDataModel(
      data["ID"],
      data["TopicName"]
    );
  }
}
