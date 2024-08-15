import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';

import '../../../Components/Toast Message Error/Toast-Message-Error.dart';
import '../../../Components/Toast Message Error/styled_toast_enum.dart';
import '../../../Model/MatchModel.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/Finding Match Loading/FindingMatchLoading.dart';
import '../../1. CommonUI/OpenPhotoCamera.dart';
import '../../1. CommonUI/PromptModal.dart';

part 'Match_Find.dart';
part 'Match_API_Related.dart';
part 'Match_CarPictures.dart';
part 'Match_NowButton.dart';
part 'Match_Filter.dart';
part 'Match_AddressTxt.dart';
part 'Match_DriverPictures.dart';

class MatchVC extends StatefulWidget {

  @override
  State<MatchVC> createState() => _MatchVC();
}

class _MatchVC extends State<MatchVC> {
  GetMatchDataModel? matchedDetail;
  bool matchCarModel = false;

  TextEditingController currentAddressTxtController = TextEditingController();
  String currentAddress = "";
  String carModel = "";
  String carTransmission = "";

  TextEditingController carModelTxtController = TextEditingController();

  List<String> listCarTransmission = ["Automatic","Manual"];

  @override
  void initState() {
    getMatchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey);
    final style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey[500]);
    final style3 = TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.grey[500]);
    final style4 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[500]);

    return
    GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: backNavigation(context, "Match"),
        body: 
        matchedDetail == null ?
        findMatchVIEW() :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 2.3),
                            borderRadius: BorderRadius.circular(12)
                          ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  spacer(20),
                  const Center(child: Text("Match", style: style1)),
      
                  spacer(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultProfilePhoto(),
      
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 1.5),
                          borderRadius: BorderRadius.circular(51)
                        ),
                        child: Icon(Icons.handshake , size: 50, color: gkGetColor(PickClr.tsuperTheme))
                      ),
      
                      defaultProfilePhoto(),
                    ],
                  ),
      
                  spacer(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: Text("Driver:", style: style3)),
                          Center(child: Text(matchedDetail?.DriverName ?? "",
                            style: style2, 
                            textAlign: TextAlign.center)
                          ),
                        ],
                      ),
      
                      const SizedBox(width: 35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: Text("Client:", style: style3)),
                          Center(child: Text(matchedDetail?.UserName ?? "",
                            style: style2, 
                            textAlign: TextAlign.center)
                          ),
                        ],
                      )
                    ],
                  ),
      
                  spacer(25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text("Found Match, you are able to communicate to each other. ", 
                    style: style4, 
                    textAlign: TextAlign.center,),
                  ),
                  spacer(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refreshState() => setState(() {});
  void startShowLoadingView() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return 
        ShowFindMatchLoading(
          carModel: matchCarModel ? carModel : "",
          currentAddress: currentAddress,
          transmission: carTransmission,
        );
      },
    ).then((value) => {
      if (value != null) {
        matchedDetail =  value as GetMatchDataModel,
        refreshState()
      }
    });
  }
}
