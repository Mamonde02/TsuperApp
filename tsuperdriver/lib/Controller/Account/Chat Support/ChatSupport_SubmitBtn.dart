part of 'ChatSupport.dart';

extension extSubmitBtn on _ChatSupportVC {
  Widget submitBtn(){
    const style1 = TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500);

    return
    Container(
      padding: const EdgeInsets.symmetric(horizontal:70, vertical: 20),
      decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[200]!)),
                    color: Colors.white,
                    boxShadow: bothBoxShadowV1
                  ),
      child: 
      MaterialButton(
        shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
        elevation: 2,
        color: gkGetColor(PickClr.tsuperTheme),
        onPressed: (){
          showNewChatTopicPromptModal();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text("Submit New Case", style: style1),
        ),
      ),
    );
  }
}