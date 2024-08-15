import 'package:flutter/material.dart';

import '../../../Components/Colors-Design.dart';
import '../../../Components/CommonFunc.dart';
import '../../../Components/GlobalVar.dart';
import '../../../Model/ChatModel.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/BackNavigation.dart';
import '../../1. CommonUI/EmptyView.dart';
import '../../1. CommonUI/PromptModal.dart';
import '../Chat Conversation/ChatConversationVC.dart';

part 'ChatList_API.dart';

class ChatListVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatListVC();
}

class _ChatListVC extends State<ChatListVC> {
  List<MatchChatListDataModel> allChat = [];

  @override
  void initState() {
    fetchMatchChatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: backNavigation(context, "Message"),
      backgroundColor: gkGetColor(PickClr.gkBGStyle2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          allChat.isEmpty ?
          Expanded(child: emptyView("NO MESSAGES YET")) :
          chatListView(),
        ],
      ),
    );
  }

  Widget chatListView(){
    final style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    const style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
    const style3 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

    return
    Expanded(
      child: ListView.builder(
        itemCount: allChat.length,
        itemBuilder: (_,i){
          return
          GestureDetector(
            onTap: (){
              if (userData?.MemberType == "Driver") {
                allChat[i].DriverUNRead = 0;
              }else{
                allChat[i].UNRead = 0;
              }

              updateMatchChatStatus(allChat[i].TransactionNo);
              
              refreshState();
              Navigator.of(context).push(createRoute(
                ChatConversationVC(txnID: allChat[i].TransactionNo,)
              ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: const Border(bottom: BorderSide(color:Color.fromRGBO(224, 224, 224, 1), width: 1.5)),
                color: (userData?.MemberType == "Driver") ?
                allChat[i].DriverUNRead == 1 ? Colors.blue[100] : gkGetColor(PickClr.gkBGStyle1) :
                allChat[i].UNRead == 1 ? Colors.blue[100] : gkGetColor(PickClr.gkBGStyle1)
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  spacer(7),
                  Text(formatDateFromDB("MM/dd/yyyy hh:mm aa", allChat[i].DateTimeIN), textAlign: TextAlign.end),
                  Text("Order No. ${allChat[i].TransactionNo}", style: style1),
                  Text(
                    userData?.MemberType == "Driver" ? 
                    allChat[i].ClientName : 
                    allChat[i].DriverName, 
                    style: style2
                  ),
                  Text(allChat[i].Schedule, style: style3),
                  spacer(12)
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void refreshState() => setState(() {});
}