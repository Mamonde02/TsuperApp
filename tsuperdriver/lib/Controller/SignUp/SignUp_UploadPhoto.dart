part of 'SignUpVC.dart';

extension extSignUpUploadPhoto on _SignUpVC {
  Widget uploadCarModelTransmissionVIEW(){
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    selectedMemberType == "Car Owner" ?
    Column(
      children: [
        spacer(10),
        const Text("Upload Required Requirements", style: style1),
        spacer(3),
        driverLicenseVIEW(),
        driverCarVIEW(),
        carRegistrationVIEW()
      ],
    ) :

    Column(
      children: [
        spacer(10),
        const Text("Upload Required Requirements", style: style1),
        driverLicenseVIEW(),

        spacer(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            validIDUploadBtn(),
            const SizedBox(width: 15),
            (validID.isNotEmpty) ?
            imgViewer(validIDImg!) :
            Container(),
          ],
        ),
      ],
    );
  }

  Widget carModelUploadBtn(){
    final style1 =  TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    return
    MaterialButton(
      shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.5),
                side: BorderSide(color: gkGetColor(PickClr.gkBtnColor), width: 1.5)
              ),
      elevation: 2,
      onPressed: () async{
        final image = await showSelectPhotoCameraModalView(context);
        if ((image?.path ?? ".") != "."){
          final finalName = "${fnameTxtController.text}-CarModel-${getDateFromNOW("hhmmssddyyyyMM")}";
          carModel = [image,finalName];
          carModelImg = await image!.readAsBytes();
          setState(() {});
        }
      },
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Upload Car Model", style: style1),
      ),
    );
  }
  
  Widget validIDUploadBtn(){
    final style1 =  TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));

    return
    MaterialButton(
      shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.5),
                side: BorderSide(color: gkGetColor(PickClr.gkBtnColor), width: 1.5)
              ),
      elevation: 2,
      onPressed: () async{
        final image = await showSelectPhotoCameraModalView(context);
        if ((image?.path ?? ".") != "."){
          final finalName = "${fnameTxtController.text}-ValidID-${getDateFromNOW("hhmmssddyyyyMM")}";
          validID = [image,finalName];
          validIDImg = await image!.readAsBytes();
          setState(() {});
        }
      },
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text("Valid ID", style: style1),
      ),
    );
  }
  
  // Future uploadImage() async {
  //   Map<String, dynamic> legalInfo = {};
  //   if (selectedMemberType == "Car Owner"){
  //     var storageRef = FirebaseStorage.instance.ref("driver and car/${carModel[1]}.jpg");
      
  //     try {
  //       final metadata = SettableMetadata(
  //         contentType: 'image/jpeg',
  //         customMetadata: {'picked-file-path': carModel[0].path},
  //       );
  //       final firebaseUpld = await storageRef.putFile(File(carModel[0].path), metadata);
  //       final imageURL = await firebaseUpld.ref.getDownloadURL();
  //       legalInfo["CarModelImg"] = imageURL;
  //       legalInfo["CarName"] = carNameTxt.text;
  //       legalInfo["CarColor"] = carColorNumTxt.text;
  //       legalInfo["PlateNumber"] = carPlateNumTxt.text.toUpperCase();
  //       legalInfo["Transmission"] = carTransmission;
    
  //     } on firebase_core.FirebaseException catch (e) {
  //       print(e);
  //       return;
  //     }
      
  //     await uploadDriverLicense(legalInfo,storageRef);
  //     await carRegUPLOAD(legalInfo,storageRef);
  //     await carModelUPLOAD(legalInfo,storageRef);
      
  //   }else{
  //     var storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
  //     uploadDriverLicense(legalInfo,storageRef);
      
  //     storageRef = FirebaseStorage.instance.ref("driver and car/${validID[1]}.jpg");
  //     try {
  //       final metadata = SettableMetadata(
  //         contentType: 'image/jpeg',
  //         customMetadata: {'picked-file-path': validID[0].path},
  //       );
  //       final firebaseUpld = await storageRef.putFile(File(validID[0].path), metadata);
  //       final imageURL = await firebaseUpld.ref.getDownloadURL();
  //       legalInfo["ValidID"] = imageURL;
    
  //     } on firebase_core.FirebaseException catch (e) {
  //       print(e);
  //       return;
  //     }
  //   }
    
  //   // createUserEmail(legalInfo);
  // }

  Widget imgViewer(Uint8List img, {double height = 85}) {
    return
    Expanded(
      child: 
      Container(
        clipBehavior: Clip.hardEdge,
        height: height, 
        decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
        child: 
        Image.memory(img, fit: BoxFit.fill)),
    );
  }

  Widget emptyImgView({double height = 85}) {
    return
    Expanded(
      child: Container(
        decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.3)
                    ),
        height: height,
      ),
    );
  }
}