import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

import '../../Components/Colors-Design.dart';

Future<Object?> showPromptModal(BuildContext context, String status, String msg, 
  {
    int hasTopBorder = 0,
  }){

  return 
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
    return 
    PromptModal(message: msg, status: status, hasTopBorder: hasTopBorder);
  });
}

class PromptModal extends StatelessWidget {
  final String message;
  String status = "info";
  String errorBtnNameLbl = "Close";
  int hasTopBorder = 1;

  PromptModal({
    required this.message, 
    this.hasTopBorder = 1,
    this.errorBtnNameLbl = "Close",
    this.status = "info",
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              margin: const EdgeInsets.only(top: 38, right: 35, left: 35),
              decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0)
                          ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  
                  spacer(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
                    child: 
                    Text(message,
                      style: const TextStyle(fontSize: 15.5, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  spacer(25),
                  
                  hasTopBorder == 1 ? 
                  const Divider() : Container(),
                  errDialogBtn(
                    context, 
                    btnName: determineBtnLbl(),
                    btnColor:  determineBtnColor(),
                    onTap: (){
                      Navigator.of(context).pop();
                    }
                  ),
                ],
              ),
            ),

            Positioned(
              top: 5,
              child: statusIconStyle()
            )
          ],
        ),
      ],
    );
  }

  String determineBtnLbl(){
    switch (status) {
    case "error":
      return errorBtnNameLbl;
    default:
      return "OK";
    }
  }

  Color determineBtnColor(){
    switch (status) {
    case "error":
      return Colors.red;
    case "info":
      return gkGetColor(PickClr.gkBGTheme);
    case "success":
      return gkGetColor(PickClr.pdyGreenTheme);
    case "warning":
      return Colors.orange;
    default:
      return Colors.black;
    }
  }

  Widget statusIconStyle(){
    if (status == "info"){
      return signInfoIcon(width: 70, height: 70);

    }else if (status == "error"){
      return signErrorIcon(width: 70, height: 70);
      
    }else if (status == "warning"){
      return signWarningIcon(width: 70, height: 70);

    }else if (status == "success"){
      return signSuccessIcon(width: 70, height: 70);

    }else{
      return signInfoIcon(width: 70, height: 70);
    }
  }


  Widget errDialogBtn(
    BuildContext context, 
    {String btnName = "", Color btnColor = Colors.blue, double fSize = 18, required Function()? onTap}
    ){
    return
    InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 22),
        child:  Text(btnName,
          style: TextStyle(color: btnColor, fontSize: fSize, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Widget signErrorIcon({double height = 65, double width = 65}) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height/2), 
                    color: Colors.red,
                    boxShadow: boxShadowV4
                  ),
      child: Icon(
        Icons.close_rounded,
        color: Colors.white,
        size: width - 15,
      ));
}

Widget signWarningIcon({double height = 65, double width = 65}) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height/2), 
                    color: Colors.yellow,
                    boxShadow: boxShadowV2
                  ),
      child: Icon(
        Icons.priority_high,
        color: Colors.black,
        size: width - 15,
      ));
}

Widget signSuccessIcon({double height = 65, double width = 65}) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height/2), 
                    color: gkGetColor(PickClr.pdyGreenTheme),
                    boxShadow: boxShadowV2
                  ),
      child: Icon(
        Icons.check_rounded,
        color: Colors.white,
        size: width - 15,
      ));
}

Widget signInfoIcon({double height = 65, double width = 65, double iconWidth = 15}) {
  return 
  Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width / 2), 
                  color: Colors.blue,
                  boxShadow: boxShadowV2
                ),
    child: Icon(
      Icons.priority_high,
      color: Colors.white,
      size: width - iconWidth,
    )
  );
}

Widget yesNoModal(BuildContext context, String msg){
  const style1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  return
  Material(
    color: Colors.transparent,
    child: Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35),
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacer(55),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(msg, style: style1, textAlign: TextAlign.center),
                ),
    
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Expanded(
                        child: MaterialButton(
                          color: gkGetColor(PickClr.gkBtnColor),
                          onPressed: (){
                            Navigator.of(context).pop("YES");
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text("Yes", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        )
                      ),
    
                      const SizedBox(width: 10),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.red,
                          onPressed: (){
                            Navigator.of(context).pop("NO");
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text("No", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        )
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                spacer(15)
              ],
            ),
          ),
    
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70 / 2), 
                          color: Colors.blue,
                          boxShadow: boxShadowV2
                        ),
            child: const Icon(
              Icons.priority_high,
              color: Colors.white,
              size: 50,
            )
          )
        ],
      ),
    ),
  );
}