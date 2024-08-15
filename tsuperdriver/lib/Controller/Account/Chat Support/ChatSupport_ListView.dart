part of 'ChatSupport.dart';

extension extSupportListView on _ChatSupportVC {
  Widget chatSupportListView(){
    final style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    const style2 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500);

    return
    Expanded(
      child: ListView.builder(
        itemCount: allSupportMsg.length,
        itemBuilder: (_,i){
          return
          GestureDetector(
            onTap: (){
              allSupportMsg[i].Status = "READ";
              updateChatSupportStatus(allSupportMsg[i].SupportID);
              
              refreshState();
              Navigator.of(context).push(createRoute(
                ChatConversation(supportMsgTopic: allSupportMsg[i])
              ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: const Border(bottom: BorderSide(color:Color.fromRGBO(224, 224, 224, 1), width: 1.5)),
                color: allSupportMsg[i].Status == "UNREAD" ? Colors.blue[100] : gkGetColor(PickClr.gkBGStyle1)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  spacer(7),
                  Text(formatDateFromDB("MM/dd/yyyy hh:mm aa", allSupportMsg[i].DateTimeIN), textAlign: TextAlign.end),
                  Text("Ticket ID: ${allSupportMsg[i].SupportID}", style: style1),
                  Text(allSupportMsg[i].TitleTopic, style: style2),
                  spacer(12)
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}