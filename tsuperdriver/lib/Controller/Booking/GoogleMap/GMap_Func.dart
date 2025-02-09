part of 'Mobile_GoogleMapView.dart';

extension extGoogleMap on _MobileGoogleMapView {
  LatLng centerOfTwo(){
    if (widget.selectedService == "RoundTrip" || widget.selectedService == "DropOff"){
      final pickUpArr = widget.pickupPlace.split(":::");
      final lat1 = double.parse(pickUpArr[1]);
      final long1 = double.parse(pickUpArr[2]);

      final dropOffArr = widget.dropOffPlace.split(":::");
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

  void calculateDistance(lat1, lon1, lat2, lon2){
    distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    
    if (distance > 4200){
      mapZoom = 12.0;
    }else if (distance > 2500){
      mapZoom = 13.0;
    }
  }

  double calculateDistanceV2(lat1, lon1, lat2, lon2){
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}
  