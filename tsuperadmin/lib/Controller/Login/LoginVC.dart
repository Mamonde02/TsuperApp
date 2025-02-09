import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsuperadmin/Controller/Home/HomeVC.dart';
import 'package:tsuperadmin/Server/Repo.dart';
import 'package:tsuperdriver/Components/AssetStore.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Components/Toast%20Message%20Error/Toast-Message-Error.dart';
import 'package:tsuperdriver/Components/Toast%20Message%20Error/styled_toast_enum.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/Extensions.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/LoadingView.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

part 'Login_Input.dart';
part 'Login_Btn.dart';
part 'Login_API_Related.dart';

class LoginVC extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginVC();
}

class _LoginVC extends State<LoginVC> {
  TextEditingController adminUserTxt = TextEditingController();
  TextEditingController pwdTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: gkGetColor(PickClr.gkBGStyle1),
      body: Center(child: loginViewContainer()),
    );
  }

  Widget loginViewContainer(){
    const style1 = TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white);

    return
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 0.7),
        borderRadius: BorderRadius.circular(3),
        color: gkGetColor(PickClr.tsuperTheme),
        boxShadow: bothBoxShadowV1
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spacer(35),
          Image.asset(
            AssetStoreImage.tsuperRiderLogo,
            width: 100,
            height: 100,
            fit: BoxFit.fitHeight,
          ),
          
          spacer(15),
          const Text("Tsuper Admin", style: style1),
          
          spacer(25),
          inputColumn("Username",adminUserTxt),

          spacer(15),
          inputColumn("Password",pwdTxt, isSecured: true),

          spacer(35),
          signinBtn(),
          spacer(35),
        ],
      ),
    );
  }
  
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