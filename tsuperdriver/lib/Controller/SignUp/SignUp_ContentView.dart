part of 'SignUpVC.dart';

extension extSignUpContentView on _SignUpVC {
  Widget txtInputFields(TextEditingController txtController, String hint, 
    {
      TextInputType keyboardType = TextInputType.text, 
      bool isSecured = false,
      List<TextInputFormatter> format = const []
    }){
    return
    Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(  
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: txtController,
        keyboardType: keyboardType,
        inputFormatters: format,
        obscureText: isSecured,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 15),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: hint,
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[400])
        ),
      ),
    );
  }

  Widget carNameTxtField(){
    return
    Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(  
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: carNameTxt,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: "Enter Car Name",
          hintStyle: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w400, color: Colors.grey[400])
        ),
      ),
    );
  }

  Widget carPlateNumbeTxtField(){
    return
    Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(  
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: carPlateNumTxt,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        inputFormatters:  [LengthLimitingTextInputFormatter(6)],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: "Enter Plate Number",
          hintStyle: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w400, color: Colors.grey[400])
        ),
      ),
    );
  }
  
  Widget carColorxtField(){
    return
    Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(  
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: carColorNumTxt,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: "Enter Car Color",
          hintStyle: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w400, color: Colors.grey[400])
        ),
      ),
    );
  }
}