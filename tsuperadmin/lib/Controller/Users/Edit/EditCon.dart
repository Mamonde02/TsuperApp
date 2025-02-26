import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/Extensions.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

import '../../../Server/Repo.dart';

// part 'Edit_MemberType.dart';
// part 'Edit_UpdateCancelBtn.dart';
part 'Edit_API_Con.dart';

// testing only....
class EditVCtwo extends StatefulWidget {

  UserAccountDataModel acc;

  EditVCtwo({super.key, required this.acc});

  @override
  State<StatefulWidget> createState() => _EditVCtwo();
}

// set this to the state class
class _EditVCtwo extends State<EditVCtwo> {

  TextEditingController fnameTxtController = TextEditingController();
  TextEditingController lnameTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController currentAddTxtController = TextEditingController();

  String selectedMemberType = "";
  List<String> listOfMemberType = ["Car Owner", "Driver"];


  @override
  void initState() {

    // Let the parent class do its work first.
    super.initState();
    
    // Now, do your own setup work.
    fnameTxtController = TextEditingController(text: widget.acc.FirstName);
    lnameTxtController = TextEditingController(text: widget.acc.LastName);
    emailTxtController = TextEditingController(text: widget.acc.Email);
    currentAddTxtController = TextEditingController(text: widget.acc.CurrentAddress);
    selectedMemberType = widget.acc.MemberType;

  }

  // ctrl + space == suggestion

  
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
                  const Text("Confirmation Account", style: style1),
                  spacer(35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(child: txtInput("Confirm First Name", fnameTxtController)),

                        const SizedBox(width: 15),
                        Expanded(child: txtInput("Confirm Last Name", lnameTxtController))
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
  


  // widgets components
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



  Widget dropDownContainerVIEW(){
    return
    Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: gkGetColor(PickClr.gkSkyBlue))
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        hint: Text("Select Member Type",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400])),
        elevation: 2,
        value: selectedMemberType == "" ? null : selectedMemberType,
    
        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),
    
        // Array list of items
        items:  
        listOfMemberType.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items, style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),
        
        onChanged: (String? newValue) async{
          selectedMemberType = newValue!;
          refreshState();
        },
      ),
    );
  }



  Widget updateCancelRowButton(){
    return
    SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
            child: MaterialButton(
              color: gkGetColor(PickClr.gkBtnColor),
              onPressed: (){
                // updateUser(widget.acc);
                confirmUser(widget.acc);

               // Toast message
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                      "Successfully user Confirm.", 
                      style: TextStyle(
                        fontSize: 17, 
                        color: Colors.white, 
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: Color(0xFFff7a01),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Confirm account", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            )
          ),

          const SizedBox(width: 10),
          Expanded(
            child: MaterialButton(
              color: Colors.red,
              onPressed: (){
                selectedMemberType = "";
                Navigator.of(context).pop("NO");
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Cancel", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            )
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }


  void refreshState() => setState(() {});
}


