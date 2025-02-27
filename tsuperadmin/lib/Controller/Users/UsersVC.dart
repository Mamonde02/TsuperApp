import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsuperadmin/Controller/Users/Edit/Edit.dart';
import 'package:tsuperadmin/Controller/Users/Edit/EditCon.dart';
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
  List<String> listOfMemberType = ["", "Car Owner", "Driver"];

  @override
  void initState() {
    fetchAllUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: gkGetColor(PickClr.gkBtnColor),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [searchTxtView(), const SizedBox(width: 30)],
            ),
          ),
          const SizedBox(height: 10),
          searchDropTxtView(),
          const SizedBox(height: 10),
          usersListVIEW()
        ],
      ),
    );
  }

  Future<Object?> showConfirmationPromptModal(
      String msg, UserAccountDataModel acc) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return yesNoModal(context, msg);
        }).then((value) => {
          if (value == "YES") {deleteUser(acc)}
        });
  }

  // testing only.... added this function
  Future<Object?> showEditConfirm(UserAccountDataModel acc) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return
              // from edit class super
              // EditVC(acc: acc);
              EditVCtwo(acc: acc);
        }).then((value) => {
          if (value == "YES") {fetchAllUsers()}
        });
  }

  // drop down
  Widget searchDropTxtView() {
    return Container(
      // padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.5),
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        hint: Text(
          "Select Member Type",
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400]),
        ),
        elevation: 2,
        value: selectedMemberType == "" ? null : selectedMemberType,

        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),

        // Array list of items
        items: listOfMemberType.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),

        onChanged: (value) {
          setState(() {
            selectedMemberType = value!;
            // amountListOfRegular();

            displayedUsersData = allUsersData.where((e) {
              // final fullName =
              //     "${e.FirstName.toLowerCase()} ${e.LastName.toLowerCase()}";
              final memberType = e.MemberType.contains(value);
              return memberType;
              // memberType.toLowerCase().contains(value.toLowerCase());
            }).toList();
          });
        },
      ),
    );
  }

  void refreshState() => setState(() {});
}
