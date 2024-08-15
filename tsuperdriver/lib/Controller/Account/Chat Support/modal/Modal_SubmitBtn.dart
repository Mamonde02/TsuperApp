part of 'Modal_SubmitChatTopic.dart';

extension extSubmitBtn on _ModalSubmitChatTopic {
  Widget submitBtn(){
    const style1 = TextStyle(fontSize: 17.5, color: Colors.white);

    return
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        color: gkGetColor(PickClr.tsuperTheme),
        elevation: 2,
        onPressed: (){
          sendChatSupport();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text("SUBMIT", style: style1),
        ),
      ),
    );
  }
}