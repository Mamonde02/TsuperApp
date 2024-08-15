part of 'EditProfileVC.dart';

extension extTxtField on _EditProfileVC {
  Widget columnTextInputVIEW() {
    return
    Column(
      children: [
        txtFields("First Name", fnameTxtController),
        txtFields("Last Name", lnameTxtController),
        googlePlaceSearch(),
        txtFields(
          "Phone Number", phoneNumTxtController,
          keyboardType: TextInputType.phone, 
          format: [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.digitsOnly]
        ),
        txtFields("Email Address", emailTxtController),
      ],
    );
  }

  Widget txtFields(String lbl, TextEditingController txtController,{
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter> format = const []
    }) {
    const style1 = TextStyle(fontSize: 18.5);

    return
    Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lbl, style: style1),

          spacer(2.5),
          TextField(  
            cursorColor: Colors.black,
            textAlign: TextAlign.start,
            controller: txtController,
            keyboardType: keyboardType,
            inputFormatters: format,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 15),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[400])
            ),
          ),
        ],
      ),
    );
  }
}