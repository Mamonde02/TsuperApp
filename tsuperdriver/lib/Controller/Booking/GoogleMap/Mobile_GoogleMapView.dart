import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'GMap_Func.dart';

class MobileGoogleMapView extends StatefulWidget {
  String selectedService = "DropOff";
  
  String pickupPlace = "Search Pickup Location:::0:::0";
  String dropOffPlace = "Search Drop-off Location:::0:::0";
  List<String> locations = [];

  MobileGoogleMapView({
    super.key,
    required this.selectedService,
    required this.pickupPlace,
    required this.dropOffPlace,
    required this.locations
  });

  @override
  State<MobileGoogleMapView> createState() => _MobileGoogleMapView();
}

class _MobileGoogleMapView extends State<MobileGoogleMapView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(10.3208082, 123.9546652);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // centerOfTwo

  double mapZoom = 14; // KM
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    if (widget.selectedService == "RoundTrip" || widget.selectedService == "DropOff"){
      if (widget.pickupPlace != "Search Pickup Location:::0:::0" && widget.dropOffPlace != "Search Drop-off Location:::0:::0") {
        final pickUpArr = widget.pickupPlace.split(":::");
        final lat1 = double.parse(pickUpArr[1]);
        final long1 = double.parse(pickUpArr[2]);

        final dropOffArr = widget.dropOffPlace.split(":::");
        final lat2 = double.parse(dropOffArr[1]);
        final long2 = double.parse(dropOffArr[2]);

        calculateDistance(lat1,long1,lat2,long2);
        mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition( target: centerOfTwo(), zoom: mapZoom)));
        setState(() {});
      }
      
    }else{
      if (widget.locations.length > 1){
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
        mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition( target: centerOfTwo(), zoom: mapZoom)));
        setState(() {});

      }else{
        if (widget.locations.isNotEmpty){
          final locArr = widget.locations[0].split(":::");
          final loc = LatLng(double.parse(locArr[1]),double.parse(locArr[2]));
          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 14)));
          setState(() {});
        }
      }
    }

    return
    Material(
      child:
      GoogleMap(
        onMapCreated: _onMapCreated,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        markers: Set<Marker>.of(pinPoints().values),
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: mapZoom,
        ),
      ),
    );
  }

  Map<MarkerId, Marker> pinPoints(){
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; 
    
    if (widget.selectedService == "RoundTrip" || widget.selectedService == "DropOff"){
      final pickUpArr = widget.pickupPlace.split(":::");
      final lat1 = double.parse(pickUpArr[1]);
      final long1 = double.parse(pickUpArr[2]);

      final dropOffArr = widget.dropOffPlace.split(":::");
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
}