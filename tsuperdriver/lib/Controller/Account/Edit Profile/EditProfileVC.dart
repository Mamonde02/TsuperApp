import 'dart:convert';
import 'dart:io' as io;

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/Extensions.dart';

import '../../../Components/Toast Message Error/Toast-Message-Error.dart';
import '../../../Components/Toast Message Error/styled_toast_enum.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/BackNavigation.dart';
import '../../1. CommonUI/OpenPhotoCamera.dart';
import '../../1. CommonUI/PromptModal.dart';

part 'EditProfile_ProfilePic.dart';
part 'EditProfile_API_Related.dart';
part 'EditProfile_TextField.dart';
part 'EditProfile_UpdateBtn.dart';
// part 'EditProfile_AddressTxt.dart';

class EditProfileVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileVC();
}

class _EditProfileVC extends State<EditProfileVC> {
  TextEditingController fnameTxtController = TextEditingController(text: userData?.FirstName ?? "");
  TextEditingController lnameTxtController = TextEditingController(text: userData?.LastName ?? "");
  // TextEditingController currentAddressTxtController = TextEditingController(text: userData?.CurrentAddress ?? "");
  // String currentAddress = "";
  TextEditingController phoneNumTxtController = TextEditingController(text: userData?.PhoneNumber ?? "");
  TextEditingController emailTxtController = TextEditingController(text: userData?.Email ?? "");

  @override
  void initState() {
    // currentAddress = currentAddressTxtController.text;
    setState(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: backNavigation(context, "Profile Information"),
        body: ListView(
          children: [
            spacer(25),
            profilePicView(),
      
            spacer(25),
            columnTextInputVIEW(),

            spacer(35),
            updateProfileBtn(),
            spacer(25)
          ],
        ),
      ),
    );
  }

  void refreshState() => setState(() {});
}