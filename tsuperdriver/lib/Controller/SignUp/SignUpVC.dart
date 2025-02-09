
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/Extensions.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/LoadingView.dart';


import '../../Components/Colors-Design.dart';
import '../../Components/Toast Message Error/Toast-Message-Error.dart';
import '../../Components/Toast Message Error/styled_toast_enum.dart';
import '../../Server/Repo.dart';
import '../1. CommonUI/OpenPhotoCamera.dart';
import '../1. CommonUI/PromptModal.dart';
import 'Email Verification/Firebase_Email_Verify.dart';

part 'SignUp_ContentView.dart';
part 'SignUp_SignUpButton.dart';
part 'SignUp_API_Related.dart';
part 'SignUp_UploadPhoto.dart';
part 'SignUp_MemberType.dart';
// part 'SignUp_AddressTxt.dart';
part 'SignUp_LicenseFrontBack.dart';
part 'SignUp_CarModelFrontBack.dart';
part 'SignUp_CarRegistration.dart';
// part 'SignUp_FirebaseUPLOAD.dart';

class SignUpVC extends StatefulWidget {
  const SignUpVC({super.key});


  @override
  State<SignUpVC> createState() =>_SignUpVC();
}

class _SignUpVC extends State<SignUpVC> {
  TextEditingController fnameTxtController = TextEditingController();
  TextEditingController lnameTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  // TextEditingController currentAddressTxtController = TextEditingController();
  // String currentAddress = "";
  TextEditingController phoneNumTxtController = TextEditingController();
  TextEditingController pwdTxtController = TextEditingController();
  TextEditingController confirmpwdTxtController = TextEditingController();

  TextEditingController carNameTxt = TextEditingController();
  TextEditingController carPlateNumTxt = TextEditingController();
  TextEditingController carColorNumTxt = TextEditingController();
  
  List carModelFront = [];
  List carModelBack = [];
  List carModel = [];
  List carRegistrationFront = [];
  List carRegistrationBack = [];
  List<String> listCarTransmission = ["Manual", "Automatic"];
  var carTransmission = "Automatic";

  List driverLicenseFront = [];
  List driverLicenseBack = [];
  List validID = [];

  List<String> listOfMemberType = ["Car Owner", "Driver"];
  String? selectedMemberType;

  Uint8List? licenseFront;
  Uint8List? licenseBack;
  Uint8List? carModelFrontImg;
  Uint8List? carModelBackImg;
  Uint8List? validIDImg;
  Uint8List? carModelImg;
  Uint8List? carRegImgFront;
  Uint8List? carRegImgBack;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.white, size: 30),
                      title:  const Text("Registration", 
                              style: TextStyle(fontSize: 25.5, fontWeight: FontWeight.w700,color: Colors.white)),
                    );
    
    return
    GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: appBar,
        backgroundColor: const Color(0xFFff7a01),
        body:
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacer(25),
                    txtInputFields(fnameTxtController, "First Name"),
                    txtInputFields(lnameTxtController, "Last Name"),
                    // googlePlaceSearch(),

                    txtInputFields(phoneNumTxtController, "Phone Number (09XXXXXXXXX)", 
                    keyboardType: TextInputType.phone, 
                    format: [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.digitsOnly]),
    
                    txtInputFields(emailTxtController, "Email Address"),
                    txtInputFields(pwdTxtController, "Password", isSecured: true),
                    txtInputFields(confirmpwdTxtController, "Confirm Password", isSecured: true),

                    dropDownContainerVIEW(),
                    spacer(15),

                    selectedMemberType != null ?
                    uploadCarModelTransmissionVIEW() :
                    Container(),
                    spacer(45),
                  ],
                ),
              ),
            ),
    
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 20, left: 20),
                child: signUpButtonVIEW(),
              ),
            )
          ],
        )
      ),
    );
  }

 // this is cancel loading screen
  void startShowLoadingView() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return ShowLoadingView();
      },
    );
  }
}