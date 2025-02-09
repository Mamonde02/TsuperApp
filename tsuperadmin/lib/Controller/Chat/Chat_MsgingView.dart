part of 'ChatVC.dart';

extension extChatMsgView on _ChatVC {
  Widget chatMsgVIEWRow(){
    return
    Row(
      children: [
        chatSupportListView(),
    
        (selectedChatSupport != null) ?
        chatSupportConversationVIEW() :
        Container(),
      ],
    );
  }

  Widget chatSupportListView(){
    return
    Container(
      decoration: BoxDecoration(
                    border: Border(right: 
                    BorderSide(color: gkGetColor(PickClr.gkBtnColor), width: 1.5))
                  ),
      width: 350,
      child: ListView.builder(
        itemCount: allChatSupport.length,
        itemBuilder: (_, i){
          return
          supportItemView(allChatSupport[i]);
        }
      ),
    );
  }

  Widget supportItemView(ChatSupportDataModel i){
    final style1 = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[600]!);
    const style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black);
    final style3 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[800]!);
    final style4 = TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: gkGetColor(PickClr.tsuperTheme));

    return
    InkWell(
      onTap: (){
        i.SupportStatus = "READ";
        selectedChatSupport = i;
        fetchSupportConversation(isNeedRefresh: true);
        updateChatSupportStatus();
        refreshState();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                      color: selectedChatSupport == i ?
                      Colors.blue[200] :
                      i.SupportStatus == "UNREAD" ? Colors.grey[200] : Colors.transparent 
                    ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            spacer(7),
            Text(formatDateFromDB("MM/dd/yyyy hh:mm aa", i.DateTimeIN), style: style1, textAlign: TextAlign.right),
    
            spacer(5),
            Text("Ticket ID: ${i.SupportID}", style: style4),
            spacer(3),
            Text(i.SenderName, style: style2),
    
            Text(i.TitleTopic, style: style3),
            spacer(5),
          ],
        ),
      ),
    );
  }
}