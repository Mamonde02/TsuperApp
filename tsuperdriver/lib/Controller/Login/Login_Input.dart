part of 'LoginVC.dart';

extension extLoginInputVC on _LoginVC {
  Widget inputColumn(String title, TextEditingController txtController, {bool isSecured = false}){
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white);
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(title, style: style1),
        ),

        spacer(2.5),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                      ),
          child: TextField(
            cursorColor: Colors.black,
            textAlign: TextAlign.start,
            controller: txtController,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            obscureText: isSecured,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 25, right: 10),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        )
      ],
    );
  }
}