import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/Booking/Booking%20Details/Modal_PaymentMethod.dart';
import 'package:tsuperdriver/Model/BookingModel.dart';

import '../../../../Components/Colors-Design.dart';
import '../../../../Components/CommonFunc.dart';
import '../../../../Server/Repo.dart';
import '../../../main.dart';
import '../../1. CommonUI/CustomIcon.dart';
import '../../1. CommonUI/LoadingView.dart';
import '../../1. CommonUI/PromptModal.dart';
import '../../Home/Notification/Notif.dart';

part 'BookingDetails_HeaderView.dart';
part 'BookingDetails_Confirmation.dart';
part 'BookingDetails_API_Related.dart';

class BookingDetails extends StatefulWidget {
  Map<String, dynamic> confirmationData = {};
  bool isRequestingBook = false;
  List<String> locations = [];

  BookingDetails({
    super.key,
    required this.confirmationData,
    required this.locations,
    this.isRequestingBook = false
  });

  @override
  State<BookingDetails> createState() => _BookingDetails();
}

class _BookingDetails extends State<BookingDetails> {
  String paymentMethod = "Cash";

  double totalAmount = 0; //per 100 meters = 10.00 + 45 (basefee);
  double distance = 0; // KM
  double mapZoom = 14; // KM

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    if (widget.confirmationData["TypeService"] == "RoundTrip" || widget.confirmationData["TypeService"] == "DropOff"){
      final pickUpArr = widget.confirmationData["PickUp"].split(":::");
      final lat1 = double.parse(pickUpArr[1]);
      final long1 = double.parse(pickUpArr[2]);

      final dropOffArr = widget.confirmationData["DropOff"].split(":::");
      final lat2 = double.parse(dropOffArr[1]);
      final long2 = double.parse(dropOffArr[2]);

      calculateDistance(lat1,long1,lat2,long2);
    }else{
      double totalDistance = 0;
      for(var i = 0; i < widget.locations.length-1; i++){
      final locArr1 = widget.locations[i].split(":::");
      final locArr2 = widget.locations[i+1].split(":::");
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
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
                      backgroundColor:gkGetColor(PickClr.tsuperTheme),
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.white, size: 30),
                      automaticallyImplyLeading: false,
                      actions: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: 
                          const Center(
                            child: Text("Cancel  ", 
                            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white))
                          ),
                        )
                      ],
                    );
    return
    Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  scrollGesturesEnabled: true,
                  markers: Set<Marker>.of(pinPoints().values),
                  initialCameraPosition: CameraPosition(
                    target: centerOfTwo(),
                    zoom: mapZoom,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.confirmationData["TypeService"] != "Tour" ? 
                    bookingHeaderDesignView() :
                    Container(),

                    bookingType(),
                  ],
                )
              ],
            ),
          ),
          
          // CONFIRMATION VIEW
          bookingConfirmationVIEW(),
        ],
      ),
    );
  }

  LatLng centerOfTwo(){
    if (widget.confirmationData["TypeService"] == "RoundTrip" || widget.confirmationData["TypeService"] == "DropOff"){
      final pickUpArr = widget.confirmationData["PickUp"].split(":::");
      final lat1 = double.parse(pickUpArr[1]);
      final long1 = double.parse(pickUpArr[2]);

      final dropOffArr = widget.confirmationData["DropOff"].split(":::");
      final lat2 = double.parse(dropOffArr[1]);
      final long2 = double.parse(dropOffArr[2]);

      double latitude = lat1 + lat2;
      double longitude = long1 + long2;

      return LatLng(latitude / 2, longitude / 2);

    }else{
      double lat = 0.0;
      double long = 0.0;
      
      for (var e in widget.locations) {
        final location = e.split(":::");
        lat += double.parse(location[1]);
        long += double.parse(location[2]);
      }

      return LatLng(lat / widget.locations.length, long/ widget.locations.length);
    }
  }

  Map<MarkerId, Marker> pinPoints(){
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; 
    
    if (widget.confirmationData["TypeService"] == "RoundTrip" || widget.confirmationData["TypeService"] == "DropOff"){
      final pickUpArr = widget.confirmationData["PickUp"].split(":::");
      final lat1 = double.parse(pickUpArr[1]);
      final long1 = double.parse(pickUpArr[2]);

      final dropOffArr = widget.confirmationData["DropOff"].split(":::");
      final lat2 = double.parse(dropOffArr[1]);
      final long2 = double.parse(dropOffArr[2]);

      // creating a new MARKER
      const MarkerId markerIdPickup = MarkerId("PickUP1");
      final Marker marker1 = Marker(
        markerId: markerIdPickup,
        position: LatLng(lat1,long1),
        infoWindow: InfoWindow(title: "Pick up", snippet: pickUpArr[0]),
      );

      // creating a new MARKER
      const MarkerId markerIdDropOff =  MarkerId("DropOff2");
      final Marker marker2 = Marker(
        markerId: markerIdDropOff,
        position: LatLng(lat2,long2),
        infoWindow: InfoWindow(title: "Drop Off", snippet: dropOffArr[0]),
      );

      markers[markerIdPickup] = marker1;
      markers[markerIdDropOff] = marker2;

    }else{
      var i = 0;
      for (var e in widget.locations) {
        i += 1;
        final location = e.split(":::");
        final lat2 = double.parse(location[1]);
        final long2 = double.parse(location[2]);
        // creating a new MARKER
        MarkerId markerIdDropOff =  MarkerId("DropOff2$i");
        final Marker marker2 = Marker(
          markerId: markerIdDropOff,
          position: LatLng(lat2,long2),
          infoWindow: InfoWindow(title: "Location", snippet: location[0]),
        );
        markers[markerIdDropOff] = marker2;
      }
    }

    return markers;
  }

  void calculateDistance(lat1, lon1, lat2, lon2){
    distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    
    if (distance > 4200){
      mapZoom = 12.0;
    }else if (distance > 2500){
      mapZoom = 13.0;
    }
    refreshState();
  }

  double calculateDistanceV2(lat1, lon1, lat2, lon2){
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  void refreshState() => setState(() {});
  
  Future<Object?> showPaymentMethodModal(){
    return 
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return 
        const ModalPaymentMethod();
    }).then((value) => {
      paymentMethod = value.toString(),
      refreshState()
    });
  }
  
  void startShowLoadingView() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return ShowLoadingView();
      },
    );
  }
}