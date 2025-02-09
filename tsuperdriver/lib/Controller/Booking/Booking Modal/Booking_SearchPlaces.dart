import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';

class BookingSearchPlaces extends StatelessWidget {
  TextEditingController searchPlaces = TextEditingController();

  String placesInfo = "";

  BookingSearchPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
                      backgroundColor:gkGetColor(PickClr.tsuperTheme),
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.white, size: 30),
                      title:  const Text("Search Places", 
                      style:  TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700)),
                    );
    return
    Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 27, right: 27, top: 25),
            color: Colors.white,
            child: googlePlaceSearch(context),
          ),
        ],
      ),
    );
  }

  Widget googlePlaceSearch(BuildContext context){
    return
    GooglePlaceAutoCompleteTextField(
      textEditingController: searchPlaces,
      googleAPIKey: "AIzaSyDq3mBAg7gSUGkZPkMj-bUFy45r1xzXxMc",
      inputDecoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Search Places",
      ),
      debounceTime: 1000, // default 600 ms,
      countries: const ["ph"],// optional by default null is set
      isLatLngRequired:true,// if you req is called when isLatLngRequired is true
      getPlaceDetailWithLatLng: (Prediction prediction) async {
        placesInfo = "${prediction.description.toString()}:::${prediction.lat.toString()}:::${prediction.lng.toString()}";
        Navigator.of(context).pop(placesInfo);
      },
      itemClick: (Prediction prediction) {
        searchPlaces.text= prediction.description.toString();
        searchPlaces.selection = TextSelection.fromPosition(TextPosition(offset: (prediction.description ?? ".").length));
        placesInfo = "${prediction.description.toString()}:::${prediction.lat.toString()}:::${prediction.lng.toString()}";
      },
      
      // if we want to make custom list item builder
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(
                width: 7,
              ),
              Expanded(child: Text(prediction.description??""))
            ],
          ),
        );
      },
      // if you want to add seperator between list items
      seperatedBuilder: const Divider(),
      // want to show close icon 
      isCrossBtnShown: true,
    );
  }
}