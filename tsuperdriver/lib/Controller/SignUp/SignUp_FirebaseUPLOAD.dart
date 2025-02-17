part of 'SignUpVC.dart';

extension extFirebaesUPLOAD on _SignUpVC {
  Future<void> uploadDriverLicense(Map<String, dynamic> legalInfo, Reference storageRef) async {
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': driverLicenseFront[0].path},
      );

      XFile? frontFile = await ImagePicker().pickImage(source: ImageSource.gallery);

       if (frontFile == null) return; // Cancelled

      Uint8List frontData = await frontFile.readAsBytes();


      storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
      UploadTask frontUploadTask = storageRef.putData(frontData, metadata);
      String imageURL = await (await frontUploadTask).ref.getDownloadURL();
      legalInfo["DriverLiceneseFront"] = imageURL;


      // mobile version only
      // storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
      // final firebaseUpld = await storageRef.putFile(File(driverLicenseFront[0].path), metadata);
      // final imageURL = await firebaseUpld.ref.getDownloadURL();
      // legalInfo["DriverLiceneseFront"] = imageURL;
  
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return;
    }


  //  // driverlicense
  //   try {
  //     final metadata = SettableMetadata(
  //       contentType: 'image/jpeg',
  //       customMetadata: {'picked-file-path': driverLicenseBack[0].path},
  //     );

  //      XFile? backFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  //      if (backFile == null) return; // Cancelled

  //      Uint8List backData = await backFile.readAsBytes();


  //     storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseBack[1]}.jpg");
  //     UploadTask backUploadTask = storageRef.putData(backData, metadata);
  //     String imageURL = await (await backUploadTask).ref.getDownloadURL();
  //     legalInfo["DriverLiceneseBack"] = imageURL;
      
  //     print("Parent PARAMENTER D-BACK LEGALINFO : ${legalInfo}");



       
  //     // up reference
  //     // storageRef = FirebaseStorage.instance.ref("driver and car/${frontFile.name}.jpg");
  //     // UploadTask frontUploadTask = storageRef.putData(frontData, metadata);
  //     // String imageURL = await (await frontUploadTask).ref.getDownloadURL();
  //     // legalInfo["DriverLiceneseFront"] = imageURL;



  //      // front old version
  //           // mobile version only
  //     // storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
  //     // final firebaseUpld = await storageRef.putFile(File(driverLicenseFront[0].path), metadata);
  //     // final imageURL = await firebaseUpld.ref.getDownloadURL();
  //     // legalInfo["DriverLiceneseFront"] = imageURL;
  


  //     // mobile version only
  //     // storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseBack[1]}.jpg");
  //     // final firebaseUpld = await storageRef.putFile(File(driverLicenseBack[0].path), metadata);
  //     // final imageURL = await firebaseUpld.ref.getDownloadURL();
  //     // legalInfo["DriverLiceneseBack"] = imageURL;
  
  //   } on firebase_core.FirebaseException catch (e) {
  //     print(e);
  //     return;
  //   }
  }

  Future<void> carRegUPLOAD(Map<String, dynamic> legalInfo, Reference storageRef) async {
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': carRegistrationBack[0].path},
      );
      storageRef = FirebaseStorage.instance.ref("driver and car/${carRegistrationBack[1]}.jpg"); // pass 

      // web version storage firebase

      final firebaseUpld = await storageRef.putFile(File(carRegistrationBack[0].path), metadata);
      final imageURL = await firebaseUpld.ref.getDownloadURL();
      legalInfo["CarRegistrationFront"] = imageURL;
  
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return;
    }
    
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': carRegistrationBack[0].path},
      );
      storageRef = FirebaseStorage.instance.ref("driver and car/${carRegistrationBack[1]}.jpg");
      final firebaseUpld = await storageRef.putFile(File(carRegistrationBack[0].path), metadata);
      final imageURL = await firebaseUpld.ref.getDownloadURL();
      legalInfo["CarRegistrationBack"] = imageURL;
  
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return;
    }
  }

  
  Future<void> carModelUPLOAD(Map<String, dynamic> legalInfo, Reference storageRef) async {
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': carModelFront[0].path},
      );
      storageRef = FirebaseStorage.instance.ref("driver and car/${carModelFront[1]}.jpg");
      final firebaseUpld = await storageRef.putFile(File(carModelFront[0].path), metadata);
      final imageURL = await firebaseUpld.ref.getDownloadURL();
      legalInfo["CarModelFront"] = imageURL;
  
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return;
    }

    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': carModelBack[0].path},
      );
      storageRef = FirebaseStorage.instance.ref("driver and car/${carModelBack[1]}.jpg");
      final firebaseUpld = await storageRef.putFile(File(carModelBack[0].path), metadata);
      final imageURL = await firebaseUpld.ref.getDownloadURL();
      legalInfo["CarModelBack"] = imageURL;
  
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return;
    }
  }


    Future<void> uploadDriverlBack(Map<String, dynamic> legalInfo, Reference storageRef)async {
    // Map<String, dynamic> legalInfo = {};
    
    // // Front license
    // try {
    //   final metadata = SettableMetadata(
    //     contentType: 'image/jpeg',
    //     customMetadata: {'picked-file-path': driverLicenseFront[0].path},
    //   );

    //   XFile? frontFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    //    if (frontFile == null) return; // Cancelled

    //   Uint8List frontData = await frontFile.readAsBytes();


    //   var storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
    //   UploadTask frontUploadTask = storageRef.putData(frontData, metadata);
    //   String imageURL = await (await frontUploadTask).ref.getDownloadURL();
    //   legalInfo["DriverLiceneseFront"] = imageURL;


    //   // mobile version only
    //   // storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
    //   // final firebaseUpld = await storageRef.putFile(File(driverLicenseFront[0].path), metadata);
    //   // final imageURL = await firebaseUpld.ref.getDownloadURL();
    //   // legalInfo["DriverLiceneseFront"] = imageURL;
  
    // } on firebase_core.FirebaseException catch (e) {
    //   print(e);
    //   return;
    // }


   // driverlicense
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': driverLicenseBack[0].path},
      );

       XFile? backFile = await ImagePicker().pickImage(source: ImageSource.gallery);

       if (backFile == null) return; // Cancelled

       Uint8List backData = await backFile.readAsBytes();


      storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseBack[1]}.jpg");
      UploadTask backUploadTask = storageRef.putData(backData, metadata);
      String imageURL = await (await backUploadTask).ref.getDownloadURL();
      legalInfo["DriverLiceneseBack"] = imageURL;
      
      print("PARAMENTER NEW D-BACK LEGALINFO : ${legalInfo}");



       
      // up reference
      // storageRef = FirebaseStorage.instance.ref("driver and car/${frontFile.name}.jpg");
      // UploadTask frontUploadTask = storageRef.putData(frontData, metadata);
      // String imageURL = await (await frontUploadTask).ref.getDownloadURL();
      // legalInfo["DriverLiceneseFront"] = imageURL;



       // front old version
            // mobile version only
      // storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseFront[1]}.jpg");
      // final firebaseUpld = await storageRef.putFile(File(driverLicenseFront[0].path), metadata);
      // final imageURL = await firebaseUpld.ref.getDownloadURL();
      // legalInfo["DriverLiceneseFront"] = imageURL;
  


      // mobile version only
      // storageRef = FirebaseStorage.instance.ref("driver and car/${driverLicenseBack[1]}.jpg");
      // final firebaseUpld = await storageRef.putFile(File(driverLicenseBack[0].path), metadata);
      // final imageURL = await firebaseUpld.ref.getDownloadURL();
      // legalInfo["DriverLiceneseBack"] = imageURL;
  
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return;
    }
  }
}
