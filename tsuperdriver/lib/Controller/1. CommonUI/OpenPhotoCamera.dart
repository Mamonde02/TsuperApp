import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

  Future<XFile?> showSelectPhotoCameraModalView(BuildContext context){
    final picker = ImagePicker();
    final mediaQueryData = MediaQuery.of(context);
    ValueNotifier showMenus = ValueNotifier<bool>(true);

    return
    showModalBottomSheet<XFile>(
      context: context,
      isDismissible: true,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return 
        ValueListenableBuilder(
        valueListenable: showMenus,
        builder: (parentContext, value, widget1) {
          return 
          Column(
            children: [
              const Spacer(),
              CupertinoActionSheet(
                title: null,
                message: titleModal(),

                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    isDestructiveAction: false,
                    onPressed: () async{
                      XFile? image = await picker.pickImage(source: ImageSource.camera);
                      if (image != null){
                        if(!context.mounted) return;
                        Navigator.of(context).pop(image);
                      }else{
                        return;
                      }
                    },
                    child: const Text("Camera"),
                  ),
                
                  CupertinoActionSheetAction(
                    isDestructiveAction: false,
                    onPressed: () async{
                      XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      if (image != null){                        
                        if(!context.mounted) return;
                        Navigator.of(context).pop(image);
                      }else{
                        return;
                      }
                    },
                    child: const Text("Photo Library"),
                  ),
                ]
              ),
                
              Container(
                clipBehavior: Clip.hardEdge,
                width: mediaQueryData.size.width - 17,
                decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                child: MaterialButton(
                  color:const Color(0xFFEEEEEE),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue[600])),
                ),
              ),
              spacer(15)
            ],
          );
        });
      }
    ).then((value) {
      return value;
    });
  }

  Widget titleModal(){
    return
    Column(
      children: [
        const Text("Photo Source", style: TextStyle(fontSize: 15)),
        
        spacer(5),
        const Text("Select Mode", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
      ],
    );
  }

  Widget defaultProfilePhoto({double height = 70, double width = 70}){
    return
    Container(
      decoration: BoxDecoration(
                    color: gkGetColor(PickClr.tsuperTheme),
                    borderRadius: BorderRadius.circular(height/2)
                  ),
      height: height, width: width,
      child: 
      const Icon(Icons.person, color:Color.fromARGB(255, 255, 166, 1), size: 60),
    );
  }