part of 'ChatConversation.dart';

extension extSendMsgBtn on _ChatConversation {
  Widget sendConversationBtn(){
    return
    Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: bothBoxShadowV1
                  ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5, right:  10),
              child: TextField(
                maxLines: 3,
                minLines: 1,
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: gkGetColor(PickClr.gkSkyBlue))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: gkGetColor(PickClr.gkSkyBlue))
                  ),
                ),
                onChanged: (value){
                  refreshState();
                },
              )
            ),
          ),

          InkWell(
            onTap: msgTxtController.text.isEmpty ? null : 
            (){
              sendChatSupport();
            },
            child: Icon(Icons.send, 
            color: msgTxtController.text.isEmpty ? Colors.grey[300] : Colors.blue, size: 35),
          )
        ],
      ),
    );
  }
}