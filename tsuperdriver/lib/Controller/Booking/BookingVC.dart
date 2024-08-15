import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';
import 'package:tsuperdriver/Controller/Booking/Booking%20Details/BookingDetails.dart';
import 'package:tsuperdriver/Controller/Booking/Booking%20Modal/Booking_Confirmation.dart';
import 'package:tsuperdriver/Controller/Booking/Booking%20Modal/Booking_SearchPlaces.dart';
import 'package:tsuperdriver/Controller/Booking/GoogleMap/Mobile_GoogleMapView.dart';

import '../../Components/GlobalVar.dart';
import '../../Components/Toast Message Error/Toast-Message-Error.dart';
import '../../Components/Toast Message Error/styled_toast_enum.dart';
import '../1. CommonUI/CustomIcon.dart';
import 'Waiting For Driver/WaitingForDriver.dart';

part 'Booking_TypeService.dart';
part 'Booking_HeaderView.dart';
part 'Booking_PickDropOffView.dart';
part 'Booking_Calendar.dart';
part 'Booking_SearchPlaceNow.dart';
part 'Booking Tour/BookingTour.dart';
part 'Booking_API_Related.dart';

class BookingVC extends StatefulWidget {
  bool isFromReqBooking = false;
  final TabController homeTabbarCtrlr;

  BookingVC({
    super.key,
    this.isFromReqBooking = false,
    required this.homeTabbarCtrlr,
  });

  @override
  State<BookingVC> createState() => _BookingVC();
}

class _BookingVC extends State<BookingVC> with AutomaticKeepAliveClientMixin {
  DateTime fromSelecteDate = DateTime.now();
  DateTime toSelecteDate = DateTime.now();
  String selectedService = "DropOff";
  
  TextEditingController pickTxtController = TextEditingController();
  TextEditingController dropOffTxtController = TextEditingController();
  TextEditingController serviceFeeTxtController = TextEditingController();

  String pickupPlace = "Search Pickup Location:::0:::0";
  String dropOffPlace = "Search Drop-off Location:::0:::0";

  List<String> locations = [];
  String selectedLocaiton = "";

  List<String> pickupLatLng = [];
  List<String> dropOffLatLng = [];

  final typeServicesArr = ["Drop Off", "Round Trip", "Tour"];
  @override
  void dispose() {
    pickTxtController.dispose();
    dropOffTxtController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    pickTxtController.addListener(() {
      if (pickTxtController.text.isEmpty) {
        pickupPlace =  "Search Pickup Location:::0:::0";
      }
    });

    dropOffTxtController.addListener(() {
      if (dropOffTxtController.text.isEmpty) {
        dropOffPlace = "Search Drop-off Location:::0:::0";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    AppBar appBar = AppBar(
                      backgroundColor:gkGetColor(PickClr.tsuperTheme),
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.white, size: 30),
                      automaticallyImplyLeading: false,
                      toolbarHeight: 0,
                      // title: const Text("Booking", style: style1),
                    );
    return
    GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: widget.isFromReqBooking ? 
                backNavigation(context, "Booking") : 
                appBar,
        backgroundColor: Colors.white,
        body: 
        (pendingBookingInfo?.BookerID != null) ? 
        WaitingForDriver(
          callback: refreshState,
        ) :
        
        ListView(
          shrinkWrap: true,
          children: [
            widget.isFromReqBooking ?
            Container() :
            headerTitleView(),
            
            typeOfServiceView(),
            (selectedService != "Tour") ?
            pickDropOffView() :
            locationVIEW(),

            spacer(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  calendarVIEW("From :"),
                  const SizedBox(width: 10),
                  (selectedService != "Tour") ?
                  Container() :
                  calendarVIEW("To :")
                ],
              ),
            ),
    
            Container(
              margin: const EdgeInsets.only(left: 18, right: 18, top:  35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                border: Border.all(color: gkGetColor(PickClr.tsuperTheme))
              ),
              height: 450,
              child: MobileGoogleMapView(
                selectedService: selectedService,
                pickupPlace: pickupPlace,
                dropOffPlace: dropOffPlace,
                locations: locations,
              )
            ),
    
            spacer(20),
            (widget.isFromReqBooking) ?
            enterServiceFee() : 
            Container(),

            bookNowButton(),
            spacer(35),
          ],
        ),
      ),
    );
  }

  Future<Object?> showConfirmationPromptModal(){
    return 
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return 
        BookingSearchPlaces();
    }).then((value) => {
      if (value != "" && value != null){
        locations.add(value.toString()),
        refreshState()
      }
    });
  }
  
  TextEditingController searchPlaces = TextEditingController();

  void refreshState(){
    setState(() {});
  }
  
  Future<Object?> showBookingConfirmationModal(Map<String, dynamic> confirmationData){
    return 
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return 
        BookingConfirmation(
          confirmationData: confirmationData
        );
    });
  }

  @override
  bool get wantKeepAlive => true;
}