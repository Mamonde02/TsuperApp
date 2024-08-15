import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

import '../../../Components/GlobalVar.dart';
import '../../../Model/MatchModel.dart';
import '../../../Server/Repo.dart';
import '../PromptModal.dart';

part 'FindingMatch_API.dart';

class ShowFindMatchLoading extends StatelessWidget {
  GetMatchDataModel? matchedDetail;
  
  String currentAddress = "";
  String transmission = "";
  String carModel = "";

  ShowFindMatchLoading({
    super.key,
    required this.currentAddress,
    required this.carModel,
    required this.transmission
  });

  
  @override
  Widget build(BuildContext context) {
    const style1 =  TextStyle(fontFamily: "SF-Pro-Round-Medium", color: Color(0xFF434343), fontSize: 17);
    const style2 =  TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700);
    
    if (userData?.MemberType == "Driver") {
      startDriverFindMatch(context);
    } else {
      getMatchUser(context);
    }
    return
    PopScope(
      canPop: false,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 7,
        backgroundColor: Colors.white,
        content: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 10),
                const Center(
                  child: SizedBox(
                    width: 55, height: 55,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      color: Colors.orange,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              
                spacer(15),
                const Text("Finding Match.\nPlease wait...",
                  style: style1,
                  textAlign: TextAlign.center,
                ),

                spacer(25),
                MaterialButton(
                  color: gkGetColor(PickClr.tsuperTheme),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  elevation: 2,
                  onPressed: () {
                    if (userData?.MemberType == "Driver") {
                      Navigator.of(context).pop(null);
                    } else {
                      stopFindMatch(context, transmission, carModel);
                    }
                  },
                  child: 
                  const Text("Stop Finding", 
                  style: style2),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}