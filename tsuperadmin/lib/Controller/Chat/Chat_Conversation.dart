part of 'ChatVC.dart';

extension extChatConversation on _ChatVC {
  Widget chatSupportConversationVIEW(){
    return
    Expanded(
      child: Column(
        children: [
          chatConversationListView(),
          chatSendMsgVIEW()
        ],
      ),
    );
  }

  Widget chatSendMsgVIEW(){
    return
    Container(
      decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1))
                  ),
      height: 50,
      child: TextField(
        maxLines: 3,
        minLines: 1,
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: msgTxtController,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
          hintText: "Chat here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hoverColor: Colors.transparent,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          suffixIcon: Container(
                        color: Colors.white,
                        child: InkWell(
                          onTap: (){
                            sendChatSupport();
                          },
                          child:  Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.send, 
                            color: msgTxtController.text.isEmpty ? 
                                  Colors.grey[300] : 
                                  Colors.blue, size: 30),
                          ),
                        ),
                      )
        ),
        onChanged: (value){
          refreshState();
        },
      ),
    );
  }
}