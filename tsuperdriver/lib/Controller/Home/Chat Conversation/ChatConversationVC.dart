import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';

import '../../../../Model/ChatModel.dart';
import '../../../../Server/Repo.dart';
import '../../../Components/AssetStore.dart';
import '../../1. CommonUI/PromptModal.dart';

part 'ChatConversation_API_Related.dart';
part 'ChatConversation_ListView.dart';
part 'ChatConversation_SendMsgBtn.dart';

class ChatConversationVC extends StatefulWidget {
  
  String txnID = "";
  ChatConversationVC({
    super.key, 
    required this.txnID
  });
  
  @override
  State<StatefulWidget> createState() => _ChatConversationVC();
}

class _ChatConversationVC extends State<ChatConversationVC> {
  TextEditingController msgTxtController = TextEditingController();

  List<MatchChatConversationDataModel> allChatConversation = [];
  var title = "";

  @override
  void initState() {
    fetchMessageMatch(isNeedRefresh: true);
    if (userData?.MemberType == "Driver") {
      title = pendingDriverBookingInfo?.BookerName ?? "";
    } else {
      title = pendingDriverBookingInfo?.DriverName ?? "";
    }
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
        appBar: backNavigation(context, title),
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
  
  Widget headerTitleView(){
    const style1 = TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.w700);

    return
    Container(
      height: 130,
      color: gkGetColor(PickClr.tsuperTheme),
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.5),
            child: Image.asset(AssetStoreImage.tsuperRiderLogo),
          ),

          const SizedBox(width: 15),
          const Text("TSUPER", style: style1)
        ],
      ),
    );
  }

  void refreshState() => setState(() {});
}