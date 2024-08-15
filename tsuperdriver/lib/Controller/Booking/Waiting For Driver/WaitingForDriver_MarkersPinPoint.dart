part of 'WaitingForDriver.dart';

extension extMarkerPinPoint on _WaitingForDriver {
  
  LatLng centerOfMarkerPoints(){
    double lat = 0.0;
    double long = 0.0;
    
    for (var e in locations) {
      final location = e.split(":::");
      lat += double.parse(location[1]);
      long += double.parse(location[2]);
    }

    return LatLng(lat / locations.length, long/ locations.length);
  }

  Map<MarkerId, Marker> pinPoints(){
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; 
    
    var i = 0;
    for (var e in locations) {
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

    return markers;
  }
}