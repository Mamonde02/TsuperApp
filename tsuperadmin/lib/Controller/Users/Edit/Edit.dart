import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/Extensions.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

import '../../../Server/Repo.dart';

part 'Edit_MemberType.dart';
part 'Edit_UpdateCancelBtn.dart';
part 'Edit_API_Related.dart';

class EditVC extends StatefulWidget {
  UserAccountDataModel acc;

  EditVC({super.key, required this.acc});

  @override
  State<StatefulWidget> createState() => _EditVC();
}

class _EditVC extends State<EditVC> {
  TextEditingController fnameTxtController = TextEditingController();
  TextEditingController lnameTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController currentAddTxtController = TextEditingController();

  String selectedMemberType = "";
  List<String> listOfMemberType = ["Car Owner", "Driver"];

  @override
  void initState() {
    fnameTxtController = TextEditingController(text: widget.acc.FirstName);
    lnameTxtController = TextEditingController(text: widget.acc.LastName);
    emailTxtController = TextEditingController(text: widget.acc.Email);
    // currentAddTxtController = TextEditingController(text: widget.acc.CurrentAddress);
    selectedMemberType = widget.acc.MemberType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500);
    return
    Material(
      color: Colors.transparent,
      child: ListView(
        children: [
          spacer(15),
          Center(
            child: Container(
              width: 750,
              decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        spacer(15),
                        const Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: Colors.grey[300]!, size: 35),
                        )                    
                      ],
                    ),
                  ),
                  const Text("Update User Information", style: style1),
                  spacer(35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(child: txtInput("First Name", fnameTxtController)),

                        const SizedBox(width: 15),
                        Expanded(child: txtInput("Last Name", lnameTxtController))
                      ],
                    ),
                  ),

                  spacer(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(child: txtInput("Email Address", emailTxtController)),

                        const SizedBox(width: 15),
                        Expanded(child: txtDropDownInput("Member Type")),
                      ],
                    ),
                  ),

                  spacer(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: txtInput("Current Address", currentAddTxtController)
                  ),
                  
                  spacer(25),
                  updateCancelRowButton(),
                  spacer(15)
                ],
              ),
            ),
          ),
          spacer(15),
        ],
      ),
    );
  }
  
  Widget txtInput(String lbl, TextEditingController txtController){
    final style1 = TextStyle(fontSize: 15.5, color: gkGetColor(PickClr.gkBGTheme), fontWeight: FontWeight.w700);

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lbl, style: style1),

        spacer(2),
        SizedBox(
          height: 50,
          child: TextField(
            cursorColor: Colors.black,
            textAlign: TextAlign.start,
            controller: txtController,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 10, right: 10),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: gkGetColor(PickClr.gkSkyBlue)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: gkGetColor(PickClr.gkSkyBlue)),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget txtDropDownInput(String lbl){
    final style1 = TextStyle(fontSize: 15.5, color: gkGetColor(PickClr.gkBGTheme), fontWeight: FontWeight.w700);

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lbl, style: style1),

        spacer(2),
        dropDownContainerVIEW()
      ],
    );
  }

  void refreshState() => setState(() {});
}