import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsuperadmin/Controller/Users/Edit/Edit.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

import '../../Components/GlobalVar.dart';
import '../../Server/Repo.dart';

part 'Users_API_Related.dart';
part 'Users_SearchTxt.dart';
part 'Users_ListView.dart';

class UsersVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersVC();
}

class _UsersVC extends State<UsersVC> {
  List<UserAccountDataModel> allUsersData = [];
  List<UserAccountDataModel> displayedUsersData = [];
  TextEditingController searchTxtController = TextEditingController();
  String selectedMemberType = "";
  List<String> listOfMemberType = ["Car Owner", "Driver"];

  @override
  void initState() {
    fetchAllUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
    Material(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: gkGetColor(PickClr.gkBtnColor),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                searchTxtView(),
                const SizedBox(width: 30)
              ],
            ),
          ),

          usersListVIEW()
        ],
      ),
    );
  }

  Future<Object?> showConfirmationPromptModal(String msg, UserAccountDataModel acc){
    return 
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      return 
      yesNoModal(context, msg);
    }).then((value) => {
      if (value == "YES") {
        deleteUser(acc)
      }
    });
  }
  void refreshState() => setState(() {});
}