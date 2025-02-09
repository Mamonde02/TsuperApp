import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/COMPLETE/CompleteVC.dart';
import 'package:tsuperdriver/Model/BookingModel.dart';

import '../../../Server/Repo.dart';
import '../../1. CommonUI/CustomIcon.dart';
import '../../1. CommonUI/PromptModal.dart';
import '../../Home/Chat Conversation/ChatConversationVC.dart';

part 'WaitingForDriver_MarkersPinPoint.dart';
part 'WaitingForDriver_ConfirmationView.dart';
part 'WaitingForDriver_DriverListView.dart';
part 'WaitingForDriver_API_Related.dart';
part 'WaitingForDriver_CarOwner.dart';
part 'WaitingForDriver_CompletCancelBtn.dart';
part 'WaitingForDriver_Arriving.dart';

class WaitingForDriver extends StatefulWidget {
  final Function callback;

  WaitingForDriver({
    super.key,
    required this.callback
  });

  @override
  State<WaitingForDriver> createState() => _WaitingForDriver();
}

class _WaitingForDriver extends State<WaitingForDriver> {
  List<DriverBookingQueueDataModel> driverQueue = [];

  String paymentMethod = "Cash";

  double totalAmount = 0; //per 100 meters = 10.00 + 45 (basefee);
  double distance = 0; // KM
  double mapZoom = 14; // KM

  List<String> locations = [];

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    locations = (pendingBookingInfo?.Locations ?? ".").split("##");

    double totalDistance = 0;
    for(var i = 0; i < locations.length-1; i++){
    final locArr1 = locations[i].split(":::");
    final locArr2 = locations[i+1].split(":::");
      totalDistance += calculateDistanceV2(double.parse(locArr1[1]), double.parse( locArr1[2]),
                        double.parse(locArr2[1]), double.parse(locArr2[2]));
    }

    distance = totalDistance;
    if (distance > 4200){
      mapZoom = 12.0;
    }else if (distance > 2500){
      mapZoom = 13.0;
    }

    refreshState();

    if (userData?.MemberType == "Driver") {
      checkDriverBookingQueueStatus(
        pendingBookingInfo?.TransactionNo.toString() ?? "",
        "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}", 
        userData?.ID.toString() ?? "."
      );
    }else{
      findDriverBookingQueue();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                scrollGesturesEnabled: true,
                markers: Set<Marker>.of(pinPoints().values),
                initialCameraPosition: CameraPosition(
                  target: centerOfMarkerPoints(),
                  zoom: mapZoom,
                ),
              ),
            ),
        
            confirmationView()
          ],
        ),

        (userData?.MemberType != "Driver" && pendingDriverBookingInfo != null) || 
        (userData?.MemberType == "Driver" && pendingDriverBookingInfo?.Status == "ARRIVING") ||
        (userData?.MemberType == "Driver" && pendingDriverBookingInfo?.Status == "BOOKED") ? 
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                elevation: 10,
                backgroundColor: gkGetColor(PickClr.tsuperTheme),
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.of(context).push(
                    createRoute(ChatConversationVC(
                      txnID: pendingBookingInfo?.TransactionNo ?? "",
                    ))
                  );
                },
                child: const Icon(Icons.message, color: Colors.white,),
              ),
            ),
            const SizedBox(width: 5)
          ],
        ) : Container()
      ],
    );
  }
  
  void refreshState() => setState(() {});

  double calculateDistanceV2(lat1, lon1, lat2, lon2){
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  Future<Object?> showCompleteTrxnModalView(){
    return 
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return 
        CompleteTrxn();
    }).then((value) => {
      homeTabbarCtrlr.index = 2,
      refreshState()
    });
  }
}