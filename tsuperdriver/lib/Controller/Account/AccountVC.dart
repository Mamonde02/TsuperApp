import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/Account/Chat%20Support/ChatSupport.dart';

import '../1. CommonUI/OpenPhotoCamera.dart';
import 'Edit Profile/EditProfileVC.dart';

part 'Account_HeaderView.dart';
part 'Account_Menu.dart';

class AccountVC extends StatefulWidget {
  const AccountVC({super.key});

  
  @override
  State<AccountVC> createState() => _AccountVC();
}

class _AccountVC extends State<AccountVC> {
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: gkGetColor(PickClr.gkBGStyle1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          headerTitleView(),

          spacer(25),
          accountInfoHeaderView(),

          menuVIEW(),
          // const Spacer(),
          // homeMenuServices(),
          // const Spacer(),
        ],
      ),
    );
  }
}