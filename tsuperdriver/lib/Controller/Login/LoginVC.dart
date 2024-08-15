import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/AssetStore.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/Extensions.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/LoadingView.dart';
import 'package:tsuperdriver/Controller/HomeTabbar/HomeTabbarVC.dart';
import 'package:tsuperdriver/Controller/SignUp/SignUpVC.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/CommonFunc.dart';
import '../../Components/Toast Message Error/Toast-Message-Error.dart';
import '../../Components/Toast Message Error/styled_toast_enum.dart';
import '../../Server/Repo.dart';
import '../1. CommonUI/PromptModal.dart';

part 'Login_Btn.dart';
part 'Login_Input.dart';
part 'Login_Title.dart';
part 'Login_API_Related.dart';

class LoginVC extends StatefulWidget {
  const LoginVC({super.key});


  @override
  State<LoginVC> createState() => _LoginVC();
}

class _LoginVC extends State<LoginVC> {

  TextEditingController emailTxt = TextEditingController();
  TextEditingController pwdTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white);
    final style2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.gkBtnColor));

    return
    GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFff7a01),
        appBar: AppBar(
          backgroundColor: gkGetColor(PickClr.tsuperTheme),
          toolbarHeight: 0,
          elevation: 0,
        ),
    
        body: ListView(
          padding: const EdgeInsets.only(left: 28, right: 28),
          children: [
            spacer(55),
            Image.asset(
              AssetStoreImage.tsuperRiderLogo,
              width: 150,
              height: 150,
              fit: BoxFit.fitHeight,
            ),
            loginTitleView(),
            spacer(15),
    
            inputColumn("Email",emailTxt),
            spacer(15),
            inputColumn("Password",pwdTxt, isSecured: true),
    
            spacer(55),
            signinBtn(),
    
            spacer(11),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?", style: style1,),
    
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      createRoute(
                        const SignUpVC()
                      )
                    );
                  },
                  child: Text("Sign up.", style: style2),
                )
              ],
            )
          ],
        ),
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