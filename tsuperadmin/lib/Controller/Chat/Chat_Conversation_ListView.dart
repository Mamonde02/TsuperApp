part of 'ChatVC.dart';

extension extChatListView on _ChatVC {
  Widget chatConversationListView(){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);
    Size size = MediaQuery.of(context).size;

    return
    Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 10),
        reverse: true,
        itemCount: allChatConversation.length,
        itemBuilder: (_,i){
          final senderID = allChatConversation[i].SenderID;
          final isUserSender = senderID == "." ? true : false;
          var isSameSender = false;
          if (i < allChatConversation.length - 1){
            isSameSender = allChatConversation[i+1].SenderID.toString() == allChatConversation[i].SenderID.toString() ? true : false;
          }
          return
          Row(
            mainAxisAlignment: isUserSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  margin: EdgeInsets.only(left: isUserSender ? (size.width / 2) - 35 : 10, 
                          right: isUserSender ? 5 : 70, 
                          top: isSameSender ? 2 : 12, bottom: 0),
                  decoration: BoxDecoration(
                                color:  isUserSender ? 
                                        gkGetColor(PickClr.gkBtnColor) : 
                                        gkGetColor(PickClr.gkSkyBlue),
                                borderRadius: BorderRadius.circular(15)
                              ),
                  child: 
                  Text(allChatConversation[i].Message, 
                  style: style1, textAlign: TextAlign.start)
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}